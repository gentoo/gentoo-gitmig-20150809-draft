# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

IUSE="apache2"

# See http://www.bugzilla.org/docs216/html/stepbystep.html to verify dependancies
DEPEND=">=dev-db/mysql-3.22.5
	>=dev-lang/perl-5.01
	>=dev-perl/AppConfig-1.52
	dev-perl/Template-Toolkit
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/File-Spec-0.8.2
	>=dev-perl/DBD-mysql-1.2209
	>=dev-perl/DBI-1.13
	dev-perl/TimeDate
	>=dev-perl/CGI-2.88
	>=dev-perl/GD-1.19
	dev-perl/GDGraph
	>=dev-perl/Chart-0.99c
	dev-perl/XML-Parser
	dev-perl/MIME-tools
	net-www/apache"

# removed deps:  dev-perl/Data-Dumper

src_compile() {
	:;
}

src_install () {
	if use apache2 ; then
		dodir /usr/bonsaitools/bin /etc/apache2/conf
	else
		dodir /usr/bonsaitools/bin /etc/apache/conf
	fi

	cd ${S}

	# Bugzilla originally needs perl to be installed in /usr/bonsaitools/bin
	# So let's change it for /usr/bin/perl
	perl -pi -e 's@#\!/usr/bonsaitools/bin/perl@#\!/usr/bin/perl@' *cgi *pl Bug.pm || die
	# syncshadowdb is gone
	# Copy files to /var/www/bugzilla
	insinto /var/www/bugzilla

#	doins * doesn't work recursively
	cp -r ${S}/* ${D}/var/www/bugzilla || die
# htdocs is for common apache docs, while bugzilla is a web app
# So, it's better to keep it outside

	if use apache2 ; then
		cp ${FILESDIR}/bugzilla.conf ${D}/etc/apache2/conf || die
	else
		cp ${FILESDIR}/bugzilla.conf ${D}/etc/apache/conf || die
	fi

	cp ${FILESDIR}/bugzilla.cron.* ${D}/var/www/bugzilla || die
	cp ${FILESDIR}/bz.cfg.templ ${D}/var/www/bugzilla || die
	cp ${FILESDIR}/firstcheck.sh ${D}/var/www/bugzilla || die
	cp ${FILESDIR}/cronset.sh ${D}/var/www/bugzilla || die
	chown -R apache:apache ${D}/var/www/bugzilla || die
}

pkg_config() {
	# moved here as it doesn't work in a sandbox
	cd /var/www/bugzilla || die
	if ( test -a localconfig ) ; then
	die "The following does not work on previous installations, please run checksetup.pl in /var/www/bugzilla followed by a chown -R apache:apache /var/www/bugzilla."
	fi

	einfo "Finalizing the installation of bugzilla in /var/www/bugzilla"

	echo -n "mysql bugs db name [bugs]: "; read mybugsdb
	if (test -z $mybugsdb) ; then mybugsdb="bugs" ; fi

	echo -n "mysql bugs db host [localhost]: "; read mybugshost
	if (test -z $mybugshost) ; then mybugshost="localhost" ; fi

	echo -n "mysql bugs dbuser name [bugs]: "; read mybugsuser
	if (test -z $mybugsuser) ; then mybugsuser="bugs" ; fi

	echo -n "mysql bugs dbuser password: "; read mybugspwd
	if (test -z $mybugspwd) ; then  eerror "No dbuser password" ; die ; fi

	cat bz.cfg.templ   | sed -e "s/tmpdbname/${mybugsdb}/"   > bz.cfg.templ.1
	cat bz.cfg.templ.1 | sed -e "s/tmphost/${mybugshost}/"   > bz.cfg.templ.2
	cat bz.cfg.templ.2 | sed -e "s/tmpdbuser/${mybugsuser}/" > bz.cfg.templ.3
	cat bz.cfg.templ.3 | sed -e "s/tmpdbpass/${mybugspwd}/"  > bz.cfg.pl

	if [ ! -f bz.cfg.pl ] ; then eerror "No template for db vars" ; die ; fi

	rm bz.cfg.templ.[0-9]* || die

	einfo "Setting correct privelegies"
	mysql -p mysql --exec="GRANT SELECT,INSERT,UPDATE,DELETE,INDEX, ALTER,CREATE,DROP,REFERENCES ON ${mybugsdb}.* TO ${mybugsuser}@${mybugshost} IDENTIFIED BY '${mybugspwd}'; FLUSH PRIVILEGES;"  || die

	einfo "Setting the template for localconfig variables"
	./checksetup.pl bz.cfg.pl || die
	chown -R apache:apache /var/www/bugzilla || die

	einfo "Final step: setting all html templates and db tables"
	chmod 750 /var/www/bugzilla/firstcheck.sh
	./firstcheck.sh || die

	echo -n "Do you want to set a crontab [y/N]" ; read cronyes
	chmod 750 /var/www/bugzilla/cronset.sh
	if ( test $cronyes = "y") ; then su - apache -c /var/www/bugzilla/cronset.sh ; fi

	chown -R apache:apache /var/www/bugzilla || die

	einfo "Then you just have to :"
	einfo "append to apache/conf: Include conf/bugzilla.conf"
	einfo "Restart Apache"
	einfo "login on http://yourhost/bugzilla/index.cgi and edit global parameters click *parameters* at the bottom"
	einfo "enjoy bugzilla!"

}

pkg_postinst() {
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	}
