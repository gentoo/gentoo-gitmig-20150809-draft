# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-2.0b_p2.ebuild,v 1.2 2005/06/25 20:26:07 vanquirius Exp $

inherit eutils depend.apache toolchain-funcs

MY_P=${PN/-core}-${PV/_p}
DESCRIPTION="Nagios Core - Check daemon, CGIs, docs"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="noweb perl debug apache2"
# mysql postgres
DEPEND="virtual/mailx
	!noweb? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/gd-1.8.3-r5
		${APACHE_DEPEND}
		perl? ( net-analyzer/traceroute )
	)
	perl? ( >=dev-lang/perl-5.6.1-r7 )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# If there's a gd lib on the system, it will try to build with it.
	# check if gdlib-config is on, and then check its output.
	if [[ -x ${ROOT}usr/bin/gdlib-config ]]; then
		if [[ ! $(${ROOT}usr/bin/gdlib-config --libs | grep -- -ljpeg) ]]; then
			eerror "Your gd has been compiled without jpeg support."
			eerror "Please re-emerge gd:"
			eerror "# USE="jpeg" emerge gd"
			die "pkg_setup failed"
		fi
	fi

	enewgroup nagios

	if use noweb; then
		enewuser nagios -1 /bin/bash /dev/null nagios
	else
		enewuser nagios -1 /bin/bash /dev/null apache
		usermod -G apache nagios
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.x-series-nsca.patch
	gunzip -c ${FILESDIR}/nagios.cfg-sample.gz > ./nagios.cfg-sample
}

src_compile() {
	local myconf

	if use perl
	then
		myconf="${myconf} --enable-embedded-perl --with-perlcache"
	fi

	if use debug; then
		myconf="${myconf} --enable-DEBUG0"
		myconf="${myconf} --enable-DEBUG1"
		myconf="${myconf} --enable-DEBUG2"
		myconf="${myconf} --enable-DEBUG3"
		myconf="${myconf} --enable-DEBUG4"
		myconf="${myconf} --enable-DEBUG5"
	fi

	if use noweb; then
		myconf="${myconf} --with-command-grp=nagios"
	else
		myconf="${myconf} --with-command-grp=apache"
	fi

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake CC=$(tc-getCC) nagios contrib || die "make failed"

	if use !noweb ; then
		# Only compile the CGI's if "noweb" useflag is not set.
		make CC=$(tc-getCC) DESTDIR=${D} cgis || die
	fi

	# convert config files
	emake -C contrib convertcfg || "config convert died"

}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING

	if use noweb; then
		sed -i -e 's/cd $(SRC_CGI) && $(MAKE) $@/# line removed due to noweb use flag/' \
			-e 's/cd $(SRC_HTM) && $(MAKE) $@/# line removed due to noweb use flag/' \
			Makefile
	fi

	sed -i -e 's/^contactgroups$//g' Makefile

	make DESTDIR=${D} install
	make DESTDIR=${D} install-config
	make DESTDIR=${D} install-commandmode

	docinto sample-configs
	dodoc ${D}/etc/nagios/*
	rm ${D}/etc/nagios/*

	dodoc ${S}/nagios.cfg-sample

	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d nagios


	rm ${S}/contrib/Makefile* ${S}/contrib/*.c ${S}/contrib/*.h

	#contribs are not configured by the configure script, we'll configure them overselves...
	find ${S}/contrib/ -type f | xargs sed -e 's:/usr/local/nagios/var/rw:/var/nagios/rw:;
						s:/usr/local/nagios/libexec:/usr/nagios/libexec:;
						s:/usr/local/nagios/etc:/etc/nagios:;
						s:/usr/local/nagios/sbin:/usr/nagios/sbin:;' -i

	mv contrib/ ${D}usr/nagios

	for dir in etc/nagios usr/nagios var/nagios usr/nagios/contrib
	do
		chown -R nagios:nagios ${D}/${dir} || die "Failed chown of ${D}/${dir}"
	done

	#Apache Module
	if use !noweb; then
		if use apache2; then
			insinto ${APACHE2_MODULES_CONFDIR}
			doins ${FILESDIR}/99_nagios.conf
		else
			insinto ${APACHE1_MODULES_CONFDIR}
			doins ${FILESDIR}/nagios.conf
		fi
		if use perl; then
			mv ${D}usr/nagios/contrib/traceroute.cgi ${D}usr/nagios/sbin
			fperms a+x /usr/nagios/sbin/traceroute.cgi
		fi
	fi
}

pkg_preinst() {
	keepdir /etc/nagios
	keepdir /var/nagios
	keepdir /var/nagios/archives
	keepdir /usr/nagios/share/ssi
	keepdir /var/nagios/rw

	if use noweb; then
		chown nagios:nagios ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	else
		chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	fi

	chmod ug+s ${D}/var/nagios/rw || die "Failed Chmod of ${D}/var/nagios/rw"
}

pkg_postinst() {
	einfo
	einfo "The example config files are located at /usr/share/doc/${PF}/sample-configs/."
	einfo
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute:"
	einfo "  rc-update add nagios default"
	einfo

	if use !noweb; then
		einfo "This does not include cgis that are perl-dependent"
		einfo "Currently traceroute.cgi is perl-dependent"
		einfo "To have ministatus.cgi requires copying of ministatus.c"
		einfo "to cgi directory for compiling."

		if use apache2; then
			einfo " Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
		else
			einfo " Edit /etc/conf.d/apache and add \"-D NAGIOS\""
		fi

		einfo
		einfo "That will make nagios's web front end visable via"
		einfo "http://localhost/nagios/"
		einfo

	else
		einfo "Please note that you have installed Nagios without web interface."
		einfo "Please don't file any bugs about having no web interface when you do this."
		einfo "Thank you!"
	fi

	einfo
	einfo "If your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem. You can fix this by adding nagios into"
	einfo "the group wheel, but this is not recomended."
	einfo

	einfo
	ewarn "Use /usr/nagios/contrib/convertcfg for configuration file conversion"
	einfo
}

pkg_prerm() {
	/etc/init.d/nagios stop
}
