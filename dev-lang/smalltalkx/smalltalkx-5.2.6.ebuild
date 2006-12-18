# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smalltalkx/smalltalkx-5.2.6.ebuild,v 1.2 2006/12/18 08:25:22 araujo Exp $

DESCRIPTION="The non-commercial version of a complete implementation of the Smalltalk programming language and development environment"
HOMEPAGE="http://www.exept.de/exept/english/Smalltalk/frame_uebersicht.html"
SRC_URI="mirror://gentoo/${PN}-common-${PV}.tgz
	mirror://gentoo/${PN}-linux-${PV}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND=""
RDEPEND="( || ( x11-libs/libX11
	virtual/x11 ) )"

S=${WORKDIR}/stx

src_compile() {
	einfo "This is a binary package."
	einfo "We don't need to compile anything."
}

src_install() {
	cp obsolete/INSTALL.sh obsolete/INSTALL.files .
	einfo "Running the smalltalkx installer script"
	./support/install-sh --prefix=${D}/opt/stx/${PV} \
		--verbose -app-release=5.2.6 -quiet=yes \
		`use_with doc` \
		|| die "failed installation"
	cd ${D}/opt/stx/${PV}/
	for i in `find . -type l` ; do
		foo=`ls -l ${i} | sed "s/.*-> //" | sed "s_${D}__"`
		rm $i
		ln -sf ${foo} $i
	done
	# do symbolic links
	dodir /usr/bin
	dosym /opt/stx/${PV}/bin/smalltalk /usr/bin/smalltalk
	dosym /opt/stx/${PV}/bin/stx /usr/bin/stx
	dosym /opt/stx/${PV}/bin/stc /usr/bin/stc
	# setup the library path
	echo "STX_LIBDIR=/opt/stx/${PV}/lib/" > ${WORKDIR}/50smalltalkx
	doenvd ${WORKDIR}/50smalltalkx
}
