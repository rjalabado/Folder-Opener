import UIKit
import CoreServices

class ViewController: UIViewController, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a button
        let selectFolderButton = UIButton(type: .system)
        selectFolderButton.setTitle("Select Folder", for: .normal)
        selectFolderButton.addTarget(self, action: #selector(selectFolderTapped), for: .touchUpInside)
        view.addSubview(selectFolderButton)
        
        // Add constraints to center the button in the view
        selectFolderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectFolderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectFolderButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc func selectFolderTapped() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeFolder)], in: .open)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Handle the selected folder URL here
        guard let selectedUrl = urls.first else { return }
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: selectedUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            print(contents)
            // You can display the contents in a table view or in any other way you want
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle the cancellation here
        print("Document picker was cancelled")
    }
}
