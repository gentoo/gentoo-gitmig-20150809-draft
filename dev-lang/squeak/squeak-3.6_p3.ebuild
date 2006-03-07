# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak/squeak-3.6_p3.ebuild,v 1.6 2006/03/07 11:21:17 araujo Exp $

inherit nsplugins libtool flag-o-matic eutils

MY_PV=${PV/_p/-}
DESCRIPTION="Highly-portable Smalltalk-80 implementation"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://www-sor.inria.fr/~piumarta/squeak/unix/release/Squeak-${MY_PV}.src.tar.gz
	mozilla? ( http://squeakland.org/installers/SqueakPlugin.image.zip )"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X nas mmx mozilla"
# a ffi flag would be nice

DEPEND="nas? ( media-libs/nas )
	X? ( || ( ( x11-libs/libX11
	            x11-libs/libXext )
		virtual/x11 ) )"
RDEPEND="${DEPEND}
	virtual/squeak-image"

S="${WORKDIR}/Squeak-${MY_PV}"

src_compile() {
	local myconf=""

	strip-flags
	filter-mfpmath sse
	filter-flags "-fPIC" "-maltivec" "-mabi=altivec" "-fstack-protector" "-pipe" "-g" "-mtune" "-march" "-mcpu" "-O" "-O1" "-O2" "-Os" "-O3" "-freorder-blocks" "-fprefetch-loop-array" "-fforce-addr"

	use X || myconf="--without-x"
	use mmx && myconf="${myconf} --enable-mpg-mmx"
	use mozilla || myconf="${myconf} --without-npsqueak"
	# use oss && myconf="${myconf} --with-audio=oss"
	# use nas && myconf="${myconf} --with-audio=nas"

	# fix tail problems
	cd ${S}/platforms/unix/config
	sed -i -e 's/tail -1/tail -n 1/g' mkconfig.in
	sed -i -e 's/tail -1/tail -n 1/g' verstamp
	chmod +x verstamp

	cd ${S}

	mkdir build
	cd build
	#CPPFLAGS: for nas
	CPPFLAGS="-I/usr/X11R6/include" ../platforms/unix/config/configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "configure failed"
	emake || die
}

src_install() {
	cd ${S}/build
	make ROOT=${D} docdir=/usr/share/doc/${PF} install || die

	exeinto /usr/lib/squeak; doexe inisqueak
	dosym /usr/lib/squeak/inisqueak /usr/bin/inisqueak

	### the rest is all for the plugin
	if use mozilla ; then
		inst_plugin /usr/lib/squeak/${MY_PV}/npsqueak.so

		dodoc nps/README.npsqueak
		dohtml -a html,sts nps/test/*

		# maybe we should install the image here..
		insinto /usr/lib/squeak
		newins ${WORKDIR}/SqueakPlugin.image npsqueak.image
	fi
}

pkg_postinst() {
	einfo 'Run "inisqueak" to get a private copy of the VM image.'
}
