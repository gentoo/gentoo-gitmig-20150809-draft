# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-oh323/asterisk-oh323-0.6.7.ebuild,v 1.1 2005/09/20 16:10:59 stkn Exp $

inherit eutils flag-o-matic

IUSE="debug"

DESCRIPTION="H.323 Support for the Asterisk soft PBX"
HOMEPAGE="http://www.inaccessnetworks.com/projects/asterisk-oh323/"
SRC_URI="http://www.inaccessnetworks.com/projects/asterisk-oh323/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
DEPEND="=dev-libs/pwlib-1.8*
	=net-libs/openh323-1.15*
	<net-misc/asterisk-1.2.0_beta1
	!>=net-misc/asterisk-1.2.0_beta1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.6.7-Makefile.diff

	# set our own cflags
	sed -i  -e "s:^\(CPPFLAGS[\t ]\+=\)\(.*\) -Os:\1 ${CXXFLAGS} \2:" \
		-e "s:^\(CFLAGS[\t ]\+=\)\(.*\):\1 ${CFLAGS} \2:" \
		rules.mak

	# disable wraptracing if you dont need it
	use debug \
		|| sed -i -e "s:^\(WRAPTRACING\).*:\1=0:" Makefile

#	# link statically 
#	use static \
#		&& sed -i -e "s:^\(OH323STAT\).*:\1=1:" Makefile
}

src_compile() {
	# NOTRACE=1 is set in the Makefile
	# emake breaks version detection of pwlib and openh323
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc BUGS CONFIGURATION COPYING README TESTS

	# fix permissions
	if [[ -n "$(egetent group asterisk)" ]]; then
		chown -R root:asterisk ${D}etc/asterisk
		chmod -R u=rwX,g=rX,o= ${D}etc/asterisk
	fi
}
