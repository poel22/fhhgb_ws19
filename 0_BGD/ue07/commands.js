// test data
db.degprg.insertOne({ _id: "prg1", name: "Program 1", semesters: 6, description: "Lorem Ipsum" });
db.degprg.insertOne({ _id: "prg2", name: "Program 2", semesters: 6, description: "Lorem Ipsum" });
db.students.insertOne({ _id: "mat1", degprg: "prg1", name: "Max Muster", start: "01.01.1970" });
db.students.insertOne({ _id: "mat2", degprg: "prg1", name: "Max Master", start: "01.01.1970" });
db.students.insertOne({ _id: "mat3", degprg: "prg2", name: "Max Masta", start: "01.01.1970" });
db.subjects.insertOne({ _id: "sub1", degprg: "prg1", semester: 1, description: "Lorem Ipsum", ects: 5 });
db.subjects.insertOne({ _id: "sub2", degprg: "prg2", semester: 2, description: "Lorem Ipsum", ects: 10 });
db.subjects.insertOne({ _id: "sub3", degprg: "prg1", semester: 2, description: "Lorem Ipsum", ects: 8 });
db.grades.insertOne({ _id: "rt1", subjectid: "sub1", studentid: "mat1", grade: 3 });
db.grades.insertOne({ _id: "rt2", subjectid: "sub3", studentid: "mat1", grade: 3 });
db.grades.insertOne({ _id: "rt3", subjectid: "sub2", studentid: "mat3", grade: 3 });

// a)
db.degprg.aggregate([{$match: {_id: "prg1"}}, {$lookup: {from:"students", localField: "_id", foreignField: "degprg", as: "students"}}]);

// b)
db.degprg.aggregate([{$match: {_id: "prg1"}}, {$lookup: {from:"subjects", localField: "_id", foreignField: "degprg", as: "subjects"}}]);

// c)
db.students.aggregate([{$match: {_id: "mat1"}}, {$lookup: {from:"grades", localField: "_id", foreignField: "studentid", as: "grades"}}]);

// d)
db.subjects.find({_id: "sub1"}, {_id: 0});
