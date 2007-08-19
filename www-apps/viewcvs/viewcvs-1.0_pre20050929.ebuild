# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewcvs/viewcvs-1.0_pre20050929.ebuild,v 1.7 2007/08/19 12:27:59 phreak Exp $

inherit webapp depend.apache eutils

PDATE=${PV/1.0_pre/}
DESCRIPTION="a web interface to cvs and subversion"
HOMEPAGE="http://viewcvs.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${PDATE}.tar.bz2"

LICENSE="viewcvs"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="cvsgraph enscript mod_python mysql standalone"

want_apache

RDEPEND="|| ( >=dev-util/cvs-1.11
			  dev-util/subversion )
		dev-lang/python
		>=app-text/rcs-5.7
		sys-apps/diffutils
		cvsgraph? ( dev-util/cvsgraph )
		enscript? ( app-text/enscript )
		apache2? ( mod_python? ( www-apache/mod_python ) )
		!apache2? ( www-servers/lighttpd )
		mysql? ( virtual/mysql
				 dev-python/mysql-python )"

S=${WORKDIR}/${PN}

pkg_setup() {
	if has_version dev-util/subversion && ! built_with_use dev-util/subversion python ; then
		eerror "Your subversion has been built without python bindings"
		eerror "If you want subversion to work with viewcvs, please"
		eerror "enable the 'python' useflag"
		die "pkg_setup failed"
	fi
	if use mod_python && ! use apache2 ; then
		eerror "mod_python requires at least apache2"
		die "pkg_setup failed"
	fi
	if use standalone && ! built_with_use dev-lang/python tcltk ; then
		eerror "Standalone client requires tkinter, please enable the"
		eerror "tcltk useflag for python and recompile"
		die "pkg_setup failed"
	fi
	webapp_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-commitid-fix.patch
}

src_compile() {
	sed -i -e "s:1.0-dev:${PV}:" lib/viewcvs.py
}

src_install() {
	webapp_src_preinst
	dodir ${MY_CGIBINDIR}/${PN} ${MY_HOSTROOTDIR}/${PN}

	exeinto ${MY_CGIBINDIR}/${PN}
	doexe www/cgi/viewcvs.cgi

	if use mysql ; then
		exeinto ${MY_CGIBINDIR}/${PN}
		doexe www/cgi/query.cgi
	fi

	if use mod_python && use apache2 ; then
		exeinto ${MY_HTDOCSDIR}
		doexe www/mod_python/viewcvs.py www/mod_python/query.py
		if use mysql ; then
			exeinto ${MY_HTDOCSDIR}
			doexe www/mod_python/query.py
		fi
		insinto ${MY_HTDOCSDIR}
		doins www/mod_python/.htaccess
	fi

	cp -r lib/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r templates/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r tools/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	cp -r tests/ ${D}/${MY_HOSTROOTDIR}/${PN}/
	insinto ${MY_HOSTROOTDIR}/${PN}
	newins viewcvs.conf.dist viewcvs.conf.example
	newins cvsgraph.conf.dist cvsgraph.conf.example

	dosym /usr/share/doc/${PF}/html ${MY_HTDOCSDIR}/doc
	dodoc INSTALL TODO CHANGES README
	dohtml -r website/*

	if use standalone ; then
		exeinto /usr/sbin
		newexe standalone.py viewcvs-standalone
	fi

	webapp_configfile ${MY_HOSTROOTDIR}/${PN}/viewcvs.conf.example
	webapp_configfile ${MY_HOSTROOTDIR}/${PN}/cvsgraph.conf.example
	webapp_postinst_txt en ${FILESDIR}/postinstall-new-en.txt
	webapp_hook_script ${FILESDIR}/reconfig

	if use mysql && has_version "<virtual/mysql-4.1" ; then
		webapp_sqlscript mysql ${FILESDIR}/viewcvs-mysql-4.0.sql
	else
		webapp_sqlscript mysql ${FILESDIR}/viewcvs-mysql-4.1.sql
	fi

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	if use standalone ; then
		einfo "The standalone script is called viewcvs-standalone"
		einfo "instead of standalone.py for clarity sake"
	fi
}
