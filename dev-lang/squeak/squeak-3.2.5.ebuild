# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak/squeak-3.2.5.ebuild,v 1.6 2004/03/30 20:51:06 spyderous Exp $

DESCRIPTION="Highly-portable Smalltalk-80 implementation"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/3.2/unix-linux/Squeak-3.2-5.src.tar.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86"
IUSE="X oss mmx mozilla"
# a ffi flag would be nice

DEPEND="virtual/glibc
	X? ( virtual/x11 )"
RDEPEND="=dev-lang/squeak-vm-3.2*
	virtual/glibc
	 X? ( virtual/x11 )"

S="${WORKDIR}/Squeak-3.2-5"

src_compile() {
	local myconf=""

	use X || myconf="--without-x"
	use oss && myconf="${myconf} --with-audio=oss"
	use mmx && myconf="${myconf} --enable-mpg-mmx"

	cd ${S}
	mkdir build
	cd build
	../platforms/unix/config/configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "configure failed"
	mv Makefile Makefile.tmp.$$
	cat Makefile.tmp.$$|sed \
		's/$(prefix)\/doc\/squeak/$(prefix)\/share\/doc\/squeak-3.2.5/g'\
		> Makefile
	rm -f Makefile.tmp.$$
	emake || die
	make npsqueak
	# this is a bit paranoid, but we want to be sure it gets compiled now
	cd nps
	emake || die
}

src_install() {
	cd ${S}/build

	make DESTDIR=${D} ROOT=${D} install || die

	exeinto /usr/bin
	doexe inisqueak

	### the rest is all for the plugin

	cd nps

	# plugin sample, must be served to work, file:// doesnt work.

	insinto /usr/share/doc/squeak-3.2.5
	doins test/plugintest.html
	doins test/plugintest.sts

	# fix the paths

	SQ_DIR=/usr/lib/squeak
	VM_VERSION=3.2-5
	NPSQUEAK_SO=${SQ_DIR}/${VM_VERSION}/npsqueak.so
	sed "s|@SQ_DIR@|${SQ_DIR}|;s|@VM_VERSION@|${VM_VERSION}|;s|@NPSQUEAK_SO@|${NPSQUEAK_SO}|" \
		npsqueakrun.in > npsqueakrun.in.2
	sed "s|@SQ_DIR@|${SQ_DIR}|;s|@VM_VERSION@|${VM_VERSION}|;s|@NPSQUEAK_SO@|${NPSQUEAK_SO}|" \
		npsqueakregister.in > npsqueakregister
	sed 's|^ensurefile|ensurefile "${HOME}/.npsqueak/SqueakPlugin.changes" "${SQ_DIR}/npsqueak.changes"\nensurefile|' npsqueakrun.in.2 > npsqueakrun

	exeinto /usr/lib/squeak
	doexe npsqueakregister
	exeinto /usr/lib/squeak/3.2-5
	doexe npsqueakrun


	# install in browsers  (no opera use flags?)

	dodir /opt/netscape/plugins
	dosym /usr/lib/squeak/3.2-5/npsqueak.so /opt/netscape/plugins

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/netscape/plugins/npsqueak.so \
		/usr/lib/mozilla/plugins/npsqueak.so
	fi

	# maybe we should install the image here..

	# dosym /usr/lib/squeak/SqueakV3.sources /usr/lib/squeak/3.2-5/SqueakV3.sources
	# doins npsqueak.image
	# doins npsqueak.changes
}

pkg_postinst() {
	einfo 'Run "inisqueak" to get a private copy of the VM image.'
	einfo ''
	einfo 'To use the browser plugin, create a working set named npsqueak.* in /usr/lib/squeak/3.2-5/'
}
