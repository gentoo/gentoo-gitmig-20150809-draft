# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/elm/elm-2.4_rc100.ebuild,v 1.3 2003/07/13 13:32:32 aliz Exp $

# HORRIBLY SORRY FOR THIS!  BUT I WANT THE EBUILD AND IT DOESN'T
# HURT ANYTHING!  I PROMISE! :) - raker@gentoo.org
export SANDBOX_DISABLED="1"

DESCRIPTION="a classic mail client enhanced by Michael Elkins"
HOMEPAGE="http://www.ozone.fmi.fi/KEH/"
SRC_URI="http://www.ozone.fmi.fi/KEH/elm-2.4ME+100.tar.gz"

LICENSE="Elm"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha"

IUSE="spell"

DEPEND="virtual/glibc
	>=net-mail/mailbase-0.00-r5
	dev-libs/openssl
	spell? ( app-text/ispell )"

S=${WORKDIR}/elm2.4.ME+.100

src_compile() {

	cp Configure Configure.orig
	sed -e "s:install_prefix/man:install_prefix/share/man:" \
		-e "s:etc=\"\$lib\":etc=\"/etc/elm\":" \
		-e "s:dflt=\"-O\":dflt=\"${CFLAGS}\":" \
		-e "s:dflt=cc:dflt=gcc:" \
		< Configure.orig > Configure

	local myconf
	use spell && myconf="ispell=\'y\'"

	./Configure -P/usr -b ${myconf} || die "configure failed"

	make || die "make failed"

}

src_install() {

	dodir /usr/lib/elm.map.txt /usr/lib/elm.map.bin /etc/elm /usr/bin \
		/usr/share/man/man1 /usr/share/man/cat1

	cd ${S}/src
	cp Makefile Makefile.orig
	sed \
		-e "s:-G -I -C:-G -w \${D}etc/elm/elm.rc -C:" \
		< Makefile.orig > Makefile

	cd ${S}
	make \
		DEST=${D}usr/bin \
		MAN=${D}usr/share/man/man1 \
		CATMAN=${D}usr/share/man/cat1 \
		ETC=${D}etc/elm install || die "make install failed"
}
