import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    // instance members
    private var sections = [
            ["header": "First Witch",
             "content" : "Hey, when will the three of us meet up later?"],
            ["header" : "Second Witch",
             "content" : "When everything's straightened out."],
            ["header" : "Third Witch",
             "content" : "That'll be just before sunset."],
            ["header" : "First Witch",
             "content" : "Where do you want to meet?"],
            ["header" : "Second Witch",
             "content" : "The dirt patch."],
            ["header" : "Third Witch",
             "content" : "I guess we'll see Mac there."]
            ]
    
    // life cycle function for UIKit
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: "CONTENT")
        var contentInset = collectionView!.contentInset
        contentInset.top = 20
        collectionView!.contentInset = contentInset
        
        let layout = collectionView!.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        
        self.collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HEADER")
        
        flow.headerReferenceSize = CGSize(width: 100, height: 25)
        
    }
    
    func wordsInSection(section: Int) -> [String]
    {
        let content = sections[section]["content"]
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let words = content?.components(separatedBy: spaces)
        
        return words!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
         return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let words = wordsInSection(section: section)
        
        return words.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let words = wordsInSection(section: indexPath.section)
        
        // creates a new Collection View Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CONTENT", for: indexPath) as! ContentCell
        
        cell.maxWidth = collectionView.bounds.size.width
        cell.text = words[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
            let words = wordsInSection(section: indexPath.section)
            let size = ContentCell.sizeForContentString(s: words[indexPath.row], forMaxWidth: collectionView.bounds.size.width)
            
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if (kind == UICollectionView.elementKindSectionHeader)
        {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HEADER", for: indexPath) as! HeaderCell // create the header cell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = sections[indexPath.section]["header"]
            
            return cell
        }
        abort()
    }
}

