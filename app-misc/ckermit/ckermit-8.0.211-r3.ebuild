# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ckermit/ckermit-8.0.211-r3.ebuild,v 1.2 2009/04/26 20:00:02 dirtyepic Exp $

inherit versionator multilib toolchain-funcs

# Columbia University only uses the third component, e.g. cku211.tar.gz for
# what we would call 8.0.211.
MY_P="cku$( get_version_component_range 3 ${PV} )"

DESCRIPTION="combined serial and network communication software package"
SRC_URI="ftp://kermit.columbia.edu/kermit/archives/${MY_P}.tar.gz"
HOMEPAGE="http://www.kermit-project.org/"

LICENSE="Kermit"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}
	net-dialup/lrzsz"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-O:${CFLAGS}:" makefile
	sed -i -e "s:\"CC\ =\ gcc\":\"CC=$(tc-getCC)\":g" makefile

	# Look for grantpt in the right place - amd64 specific, for #202840
	stdlibdir=$(get_ml_incdir /usr/include)
	sed -i -e "s:grep grantpt /usr/include:grep grantpt ${stdlibdir}:" makefile
	sed -i -e "s:then HAVE_PTMX=':then HAVE_PTMX='-D_XOPEN_SOURCE -D_BSD_SOURCE :" makefile
}

src_compile() {
	emake KFLAGS="-DCK_SHADOW" linux || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	emake \
		DESTDIR="${D}" \
		BINDIR=/usr/bin \
		MANDIR="${D}"/usr/share/man/man1 \
		MANEXT=1 \
		install || die

	# make the correct symlink
	rm -f "${D}"/usr/bin/kermit-sshsub
	dosym /usr/bin/kermit /usr/bin/kermit-sshsub

	#the ckermit.ini script is calling the wrong kermit binary -- the one
	# from ${D}
	dosed /usr/bin/ckermit.ini
	dodoc COPYING.TXT UNINSTALL *.txt
}
