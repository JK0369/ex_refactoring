import UIKit

var recentDate: Date?

private func render(person: Person) {
    Storage.commit(message: "이름: \(person.name)")
    render(photo: person.photo)
    
    // emit대신 temp()와 emit안에 있던 위치 관련 문장 끌어내기
    emit(photo: person.photo)
    Storage.commit(message: "위치: \(person.photo?.location)")
}

private func render(photo: Photo?) {
    // render photo...
}

private func getRecentPhotos(_ photos: [Photo]) -> [Photo] {
    let recentPhotos = photos
        .filter { $0.date?.timeIntervalSince1970 ?? 0 < recentDate?.timeIntervalSince1970 ?? 0 }
    recentPhotos
        .forEach { photo in
            Storage.commit(message: "\(photo) start")
            
            // emit(photo:) 대신 temp와 emit안에 있던 위치 관련 문장 끌어내기
            emit(photo: photo)
            Storage.commit(message: "위치: \(photo.location)")
            
            Storage.commit(message: "\(photo) end")
        }
    return recentPhotos
}

func emit(photo: Photo?) {
    Storage.commit(message: "제목: \(photo?.title)")
    Storage.commit(message: "날짜: \(photo?.date)")
}

struct Person {
    var name: String?
    var photo: Photo?
}

struct Photo {
    var title: String?
    var date: Date?
    var location: String?
}

enum Storage {
    static func commit(message: String) {
        // commit message ...
    }
    static func store(value: Any) {
        // store value ...
    }
}

