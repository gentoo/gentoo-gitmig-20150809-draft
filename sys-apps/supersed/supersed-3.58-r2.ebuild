# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supersed/supersed-3.58-r2.ebuild,v 1.2 2002/09/14 15:51:25 bjb Exp $

MY_P=sed-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An enhanced version of sed which sports greater speed and the use of perl regular expressions than GNU sed."
SRC_URI="http://queen.rett.polimi.it/~paolob/seders/ssed/${MY_P}.tar.gz"
HOMEPAGE="http://queen.rett.polimi.it/~paolob/seders/ssed/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="dev-libs/libpcre
	nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}
	cd ${S}/doc
	mv sed-in.texi sed-in.texi.orig
	sed -e "s:sed:ssed:g" \
		-e "s:sss:ss:g" \
		sed-in.texi.orig > sed-in.texi

	rm *.info*
}

src_compile() {
	local myconf
	use nls ||  myconf="--disable-nls"
	use static \
		&& myconf="${myconf} --disable-html" \
		|| myconf="${myconf} --enable-html"
	
	if [ -f /bin/sed ]
	then
		echo "simple conf"
		econf ${myconf} || die
	else
		echo "bootstrap"
		./bootstrap.sh
		econf ${myconf} || die
	fi
	
	rm -f ${S}/doc/sed.info*

	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	# choose any name, but sed for now. If supersed is chosen to replace
	# good ol' sed, that will work too.
	newname="ssed"
	
	into /
	newbin sed/sed ${newname}

	dodir /usr/bin
	dosym ../../bin/${newname} /usr/bin/${newname}

	if [ -z "`use build`" ]
	then
		localsed="${D}/bin/${newname}"

		cd doc
		# this could be more elaborate, but for little point (the infos will
		# still refer to 'sed') This hack just makes the info work at all.

		doinfo ${newname}.info*

		dodir /usr/share/man/man1
		dosym sed.1.gz /usr/share/man/man1/ssed.1.gz

		cd ${S}
		dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS
	fi
}
