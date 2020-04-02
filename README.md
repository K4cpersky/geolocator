## Description of geolocator
It's REST api that locates and stores location basing on IP.

## Code style

Rubocop

## Built with:

- [Ruby 2.6.4](https://www.ruby-lang.org/en/)
- [Ruby on Rails 6.0.2](https://rubyonrails.org/)
- [Docker 19.03.8](https://www.docker.com/)

## Installing

```sh
git clone https://github.com/K4cpersky/geolocator.git

cd geolocator

sudo docker-compose build

sudo docker-compose up

sudo docker-compose run web rake db:setup

sudo docker-compose run web bundle exec rspec spec

Stop application with docker-compose down
```

## Author

* **Kacper Mekarski** - *Initial work* - [Kacper Mekarski](https://github.com/K4cpersky)

## License

MIT © [Kacper Mękarski]()
