# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcng/tcng-9h.ebuild,v 1.3 2003/12/17 11:58:17 robbat2 Exp $

DESCRIPTION="tcng - Traffic Control Next Generation"
HOMEPAGE="http://tcng.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
# block this to phase it out very shortly
KEYWORDS="-*"
IUSE=""
DEPEND="doc? ( virtual/ghostscript app-text/tetex media-gfx/transfig )
	dev-lang/perl
	virtual/os-headers
	sys-apps/iproute"
RDEPEND="sys-devel/gcc
	tcsim? ( media-gfx/gnuplot )
	dev-lang/perl
	sys-apps/iproute"

IPROUTE_PN="iproute"
IPROUTE_PV="20010824"
IPROUTE_DEBIAN_PATCH_PV="11"
IPROUTE_P="${IPROUTE_PN}-${IPROUTE_PV}"
IPROUTE_DEBIAN_PATCH="${IPROUTE_P/-/_}-${IPROUTE_DEBIAN_PATCH_PV}.diff.gz"
IPROUTE_SRCFILE="iproute2-2.4.7-now-ss${IPROUTE_PV/20}.tar.gz"

# note this project does NOT use the SF mirroring system
SRC_URI="http://tcng.sourceforge.net/dist/${P}.tar.gz
	tcsim? ( ftp://ftp.inr.ac.ru/ip-routing/${IPROUTE_SRCFILE}
	http://ftp.debian.org/debian/pool/main/i/iproute/${IPROUTE_DEBIAN_PATCH} )"

S=${WORKDIR}/tcng
IPROUTE_S=${WORKDIR}/${IPROUTE_P}

src_unpack() {
	#unpack tcng
	unpack ${P}.tar.gz

	if use tcsim; then
		#unpack iproute
		unpack ${IPROUTE_SRCFILE}
		mv iproute2 iproute-20010824
		epatch ${DISTDIR}/${IPROUTE_DEBIAN_PATCH}

		ln -s ${IPROUTE_S} ${S}/tcsim/iproute2
		mkdir -p ${S}/tcsim/linux
		ln -s /usr/include ${S}/tcsim/linux/include
	fi
}

src_compile() {
	local myconf
	use tcsim && myconf="${myconf} --with-tcsim" || myconf="${myconf} --no-tcsim"
	dodir /usr/bin
	# configure is NONSTANDARD
	./configure \
		--install-directory ${D}/usr \
		--no-manual \
		${myconf} \
		|| die "configure failed"
#		--with-tcsim <=== FIXME!
#		--kernel /usr/src/linux
#		--iproute2 ${IPROUTE_S}
	emake || die
	cd ${S}/doc
	make tcng.txt
	use doc && make tcng.pdf
}

src_install() {
	dodir /usr
	dodir /usr/bin
	# fix the install location
	export TCNG_INSTALL_CWD="/usr"
	einstall install-tcc || die "make install-tcc failed"
	if use tcsim; then
		make install-tcsim install-tests || die "make install-tcsim install-tests failed"
	fi

	# lots of doc stuff
	dodoc CHANGES COPYING.GPL COPYING.LGPL README TODO VERSION tcc/PARAMETERS
	newdoc tcsim/BUGS BUGS.tcsim
	newdoc tcsim/README README.tcsim
	cp -ra examples examples-ng ${D}/usr/share/doc/${PF}
	dodoc doc/tcng.txt doc/README.tccext
	newdoc doc/README README.doc
	if use doc; then
		dodoc doc/tcng.ps doc/tcng.pdf
	fi
}
