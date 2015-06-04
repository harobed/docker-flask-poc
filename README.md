Install
=======

You need :

* docker-machine
* docker-compose 1.3.0rc1 or upper

Start environment :

    $ docker-machine create --driver virtualbox flaskpoc
    $ source activate
    $ ./init_dnsmasq.sh
    $ docker-compose up -d

Browse to http://poc.example.com/
