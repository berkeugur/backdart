import 'package:backdart/abstracts.dart';

class Get {
  final String path;

  const Get(this.path);
}

class Post {
  final String path;

  const Post(this.path);
}

class Put {
  final String path;

  const Put(this.path);
}

class Delete {
  final String path;

  const Delete(this.path);
}

class ApiSummary {
  final String summary;

  const ApiSummary(this.summary);
}

class ApiDescription {
  final String description;

  const ApiDescription(this.description);
}

class Body {
  final Type body;
  const Body(this.body);
}
