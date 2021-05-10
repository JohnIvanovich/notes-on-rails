## Приложение для работы с заметками

предоставляет API

`GET /api/notes` - получить все заметки

`GET /api/notes/:id` - получить заметку по ID

`POST /api/notes` - создать новые заметки

тело запроса
```
{
  "notes": [
    {
      "title": "aaa",
      "description": "aaa aaa"
    },
    {
      "title": "bbb",
      "description": "bbb bbb"
    }
  ]
}
```

`PUT /api/notes` - изменить существующие заметки

тело запроса
```
{
  "notes": [
    {
      "id": 2,
      "title": "ccc",
      "description": "ccc ccc"
    }
  ]
}
```

`DELETE /api/notes` - удалить заметки

тело запроса
```
{
  "notes": [
    {
      "id": 2
    },
    {
      "id": 4
    }
  ]
}
```
