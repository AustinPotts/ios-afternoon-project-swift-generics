import Foundation

// create a generic hashable counted set struct
struct CountedSet<T: Hashable> {
    
    //Generic array
    private var countedSet = [T:Int]()
    
    // create mutating funcation that takes in generic value & returns Int
    mutating func insert(item: T) -> Int{
        
        // return an index into the dictionary that corresponds with the key-value pair
        if let index = countedSet.index(forKey: item) {
            var count = countedSet[index].value
            count += 1
            countedSet.updateValue(count, forKey: item)
            return count
        } else {
            countedSet.updateValue(1, forKey: item)
            return 1
        }
    }
    
    
    // create a mutating function to remove generic value & returns Int
    mutating func remove(item: T) -> Int{
        
        // doing similar but opposite opperand math as 'inset' func
        if let index = countedSet.index(forKey: item) {
            var count = countedSet[index].value
            count -= 1
            if count == 0 {
                countedSet.remove(at: index)
                return count
            } else {
                countedSet.updateValue(count, forKey: item)
                return count
            }
        } else {
            return 0
        }
    }
    
   // Support subscripting to look up current values
    subscript(_ member: T) -> Int {
        if let index = countedSet.index(forKey: member) {
            return countedSet[index].value
        } else {
            return 0
        }
    }
    
    func count() -> Int {
        return countedSet.count
    }
    
}

//extension to conform set to ExpressibleByArrayLiteral so you can initialize a counted set using an array of same-type items.
extension CountedSet: ExpressibleByArrayLiteral {
        init(arrayLiteral elements: T...) {
        self.init()
        for element in elements {
            countedSet[element] = (countedSet[element] ?? 0) + 1
        }
    }
}

// example tests
enum Material { case iron, wooden, elven, dwarvish, magic, silver }

var countedSet = CountedSet<Material>()

countedSet[.iron]

var newCountedSet: CountedSet<Material> = [.iron, .magic, .iron, .silver, .iron, .iron]

newCountedSet[.iron]
newCountedSet.remove(item: .iron)
newCountedSet.remove(item: .dwarvish)
newCountedSet.remove(item: .magic)
