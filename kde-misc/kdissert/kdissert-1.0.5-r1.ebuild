# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-1.0.5-r1.ebuild,v 1.5 2006/04/10 00:25:14 cryos Exp $

inherit kde

MY_P=${P/_/\.}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${MY_P}.tar.bz2"
#SRC_URI="http://www.kde-apps.org/content/files/12725-${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.1
	>=dev-lang/python-2.3"
RDEPEND=""
need-kde 3.4

PATCHES="${FILESDIR}/kdissert-1.0.5-bksys.diff"

LANGS="de es fr it nl pl"

src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	local LANG_INSTALL="$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))"
	scons install DESTDIR="${D}" languages="${LANG_INSTALL}"
	dodoc AUTHORS COPYING INSTALL README ROADMAP

	# fix broken doc installation
	cd ${D}/usr/share/doc/HTML
	local KDE_HTML_DIR="$(kde-config --expandvars --install html)"
	for i in $(ls) ; do
		if [ -z "$(echo "${i} en ${LANG_INSTALL}" | fmt -w 1 | sort | uniq -d)" ] ; then
			rm -rf ./${i}
		else
			rm -f ${i}/kdissert/common
			ln -s ${KDE_HTML_DIR}/${i}/common ./${i}/kdissert/common
		fi
	done
}
