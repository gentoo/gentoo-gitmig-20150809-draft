# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.59.ebuild,v 1.2 2004/01/25 09:37:23 vapier Exp $

IUSE=""

inherit eutils

OLD_PV="2.13"
OLD_P="${PN}-${OLD_PV}"
S="${WORKDIR}/${P}"
OLD_S="${WORKDIR}/${OLD_P}"
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="http://ftp.gnu.org/gnu/${PN}/${P}.tar.bz2
	mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gnu/${PN}/${OLD_P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"

LICENSE="GPL-2"
SLOT="2.5"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~ppc64"

DEPEND=">=sys-apps/texinfo-4.3
	=sys-devel/m4-1.4*"

src_unpack() {

	unpack ${A}

	cd ${OLD_S}
	epatch ${FILESDIR}/${OLD_P}-configure-gentoo.diff
	epatch ${FILESDIR}/${OLD_P}-configure.in-gentoo.diff

	cd ${S}
	# Enable both autoconf-2.1 and autoconf-2.5 info pages
	epatch ${FILESDIR}/${PN}-2.58-infopage-namechange.patch
	ln -snf ${S}/doc/autoconf.texi ${S}/doc/autoconf25.texi
}

src_compile() {

	#
	# ************ autoconf-2.5x ************
	#
	cd ${S}
	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--target=${CHOST} || die

	emake || die

	#
	# ************ autoconf-2.13 ************
	#
	cd ${OLD_S}

	sed -i 's|\* Autoconf:|\* Autoconf v2.1:|' autoconf.texi
	cp autoconf.texi autoconf.texi.orig
	sed -e '/START-INFO-DIR-ENTRY/ i INFO-DIR-SECTION GNU programming tools' \
		autoconf.texi.orig > autoconf.texi

	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--target=${CHOST} || die

	emake || die
}

src_install() {

	# install wrapper script for autodetecting the proper version
	# to use.
	exeinto /usr/lib/${PN}
	newexe ${FILESDIR}/ac-wrapper-2.pl ac-wrapper.pl
	dosed "s:2\.5x:${PV}:g" /usr/lib/${PN}/ac-wrapper.pl

	#
	# ************ autoconf-2.5x ************
	#

	# need to use 'DESTDIR' here, else perl stuff puke
	cd ${S}
	make DESTDIR=${D} \
		install || die

	for x in autoconf autoheader autoreconf autoscan autoupdate ifnames autom4te
	do
		mv ${D}/usr/bin/${x} ${D}/usr/bin/${x}-${PV}
	done
	# new in 2.5x
	dosym ../lib/${PN}/ac-wrapper.pl /usr/bin/autom4te

#	mv ${D}/usr/share/info/autoconf.info ${D}/usr/share/info/autoconf-2.5.info

	docinto ${PV}
	dodoc COPYING AUTHORS BUGS NEWS README TODO THANKS
	dodoc ChangeLog ChangeLog.0 ChangeLog.1 ChangeLog.2

	#
	# ************ autoconf-2.13 ************
	#

	# need to use 'prefix' here, else we get sandbox problems
	cd ${OLD_S}
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	for x in autoconf autoheader autoreconf autoscan autoupdate ifnames
	do
		mv ${D}/usr/bin/${x} ${D}/usr/bin/${x}-${OLD_PV}
		dosym ../lib/${PN}/ac-wrapper.pl /usr/bin/${x}
	done

	docinto ${OLD_PV}
	dodoc COPYING AUTHORS NEWS README TODO
	dodoc ChangeLog ChangeLog.0 ChangeLog.1

	# from binutils
	rm -f ${D}/usr/share/info/standards.info*
}

pkg_preinst() {

	# remove these to make sure symlinks install properly if old versions
	# was binaries
	for x in autoconf autoheader autoreconf autoscan autoupdate ifnames autom4te
	do
		if [ -e ${ROOT}/usr/bin/${x} ]
		then
			rm -f ${ROOT}/usr/bin/${x}
		fi
	done
}

pkg_postinst() {

	echo
	einfo "Please note that the 'WANT_AUTOCONF_?_?=1' have changed to:"
	echo
	einfo "  WANT_AUTOCONF=<required version>"
	echo
	einfo "For instance:  WANT_AUTOCONF=2.5"
	echo
}

