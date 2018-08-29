# ToDoList: Four ways to pass data from Model to Controller

### * Closure

### * Delegate

### * KVO

### * Notification

***

#Part1. Closure
###To use closure to communicate with ViewController is to cerate a function as a completionHandler property:
```
var completionHandler: ((_ data: String) -> Void)?

```
###Now, inside the save method, we can using this property
```
 @IBAction func saveTextInfo(_ sender: Any) {
        if item == nil {
            if let text = textView.text {
                completionHandler!(text)
            }
        }
    }
```
> ###You can also create a multiple properties or using @excaping (ex. getHTTP), All closure are optional to use, so if you don't need to do anything, you simply do not use this property. This are the benfits of this method.


***

#Part2. Delegate
### Delegation is the most common way to communicate between DataModel and ViewController.
```
protocol DataModelDelegate: AnyObject {
    func didSaveData(data: String?)
    func didChangeData(data: String?)
}
```
### Need be sure we do not create a retain cycle between the delegate and the object, so we use a weak reference to delegate.
```
weak var delegate: DataModelDelegate?

```
### Can using function to add more method when we want to use: 
```
func saveData() {
	delegate?.didSaveData(data: text)
}

func ...
		
```
### Create an instance of DataModelDelegate in ViewController, assign its delegate to self and using extension to use data.

```
extension ViewController: DataModelDelegate {
    
    func didChangeData(data: String?) {
        if let data = data {
            todoItem[selectIndex] = data
            todoListTableView.reloadData()
        }
    }
}		
```

***
#Part3. KVO
### To use KVO is more like the Notification, we can add observe in everywhere, for example we can add observer in UITextView.text to detact the value changed or not:

```
datamodel?.addObserver(self, forKeyPath: "textView.text", options: [.old], context: nil)

```
### And using this method to use if the value(forKeyPath) have changed

```
override func observeValue(forKeyPath keyPath: 
String?, of object: Any?, change: 
[NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {....

```
> The options can select not only one, we can use an array to input the method, ex: [.old, .new, ..... ] depand on the value change way.




***
#Part4. Notification
### Add a variable to store our data in Model

```
struct NotificationInfo {
   static let message = ""
}
```
> Can use the extension and static to set the Notification Name:

```
extension Notification.Name {
    static let didSave = Notification.Name("SaveInfo")
   }
```

### After we update the data (save or change), we want to post a Notification: 
```
 NotificationCenter.default.post(name: .didSave, 
 object: nil, userInfo: [NotificationInfo.message: 
 textView.text])
```
### Now we just need to add a listener to this notification in every ViewController that uses this data.
```
 NotificationCenter.default.addObserver(self, 
 selector: #selector(addSaveInfo(noti:)), name:
 saveName, object: nil)
```

### Now the observer will listen to any updates in DataModel and call addSaveInfo method on every change.
