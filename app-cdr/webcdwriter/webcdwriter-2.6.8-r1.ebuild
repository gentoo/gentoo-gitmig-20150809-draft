# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/webcdwriter/webcdwriter-2.6.8-r1.ebuild,v 1.1 2005/08/07 00:29:52 pylon Exp $

inherit eutils java-pkg

MY_P="${P/cd/CD}"
DESCRIPTION="Make a single CD-writer available to the users in your network"
HOMEPAGE="http://joerghaeger.de/webCDwriter/index.html"
SRC_URI="http://joerghaeger.de/webCDwriter/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="java pam mp3 sox oggvorbis"

RDEPEND="
	app-cdr/cdrdao
	app-cdr/cdrtools
	mp3? ( media-sound/mpg123 )
	sox? ( media-sound/sox )
	oggvorbis? ( media-sound/vorbis-tools )
	java? ( >=virtual/jre-1.4 )"
DEPEND="java? ( >=virtual/jdk-1.4 )
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	epatch ${FILESDIR}/configure.patch
	epatch ${FILESDIR}/config-root.patch

	local myconf

	use pam || myconf="--pam"
	myconf="${myconf} --user=root --group=root"
	./configure ${myconf} || die "configure failed"
	make || die "make failed"
}

src_install() {

	exeinto /etc/init.d/
	newexe ${FILESDIR}/${PN}.rc CDWserver

	diropts -m700
	dodir /etc/CDWserver
	keepdir /var/CDWserver/bin
	dodir /var/CDWserver/export/Server/tools
	dodir /var/CDWserver/http/rcdrecord
	keepdir /var/CDWserver/projects
	keepdir /var/log/CDWserver
	keepdir /var/spool/CDWserver

	insinto /etc/CDWserver

	mv ${S}/webCDcreator/start.html ${S}/webCDcreator/index.html

	cd ${S}/CDWserver/config
	for name in `find -name '[!M]*' -type f`
	do
		doins ${name}
	done

	cd ${S}/CDWserver/http
	for dirname in `find -type d`
	do
		cd ${S}/CDWserver/http/${dirname}
		dodir /var/CDWserver/http/${dirname}
		insinto /var/CDWserver/http/${dirname}
		for name in `find -name '[!M]*' -type f`
		do
			doins ${name}
		done
	done

	insinto /var/CDWserver/http/rcdrecord

	cd ${S}/rcdrecord
	for name in `find -name '*.html'`
	do
	    doins ${name}
	done

	cd ${S}/webCDcreator
	for dirname in `find -type d`
	do
		cd ${S}/webCDcreator/${dirname}
		dodir /var/CDWserver/http/webCDcreator/${dirname}
		insinto /var/CDWserver/http/webCDcreator/${dirname}
		for name in `find -name '[!Mak]*' -type f`
		do
			doins ${name}
		done
	done

	cd ${S}

	dosbin ${S}/CDWserver/CDWserver
	dobin ${S}/CDWserver/CDWrootGate
	dobin ${S}/CDWserver/CDWverify
	dobin ${S}/CDWserver/setScheduler
	dobin ${S}/rcdrecord/rcdrecord

	dosym /usr/sbin/CDWserver /usr/sbin/CDWpasswd
	dosym /usr/sbin/CDWserver /usr/sbin/CDWuseradd
	dosym /usr/bin/rcdrecord /usr/bin/files2cd
	dosym /usr/bin/rcdrecord /usr/bin/image2cd

	insinto /var/CDWserver/export/Server/tools
	doins ${S}/MD5Verify/MD5Verify.jar

	dodoc COPYING ChangeLog README CREDITS
	dohtml *.html
}

pkg_postinst() {
	# ripped from the makefile
	einfo "Now you can start CDWserver by"
	einfo "   /etc/init.d/CDWserver start"
	einfo "Then visit"
	einfo "   http://localhost:12411"
	einfo "or try rcdrecord or files2cd on the command line."
	echo
	ewarn "Remember to setup /etc/CDWserver/config"
}
