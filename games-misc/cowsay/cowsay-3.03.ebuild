# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/cowsay/cowsay-3.03.ebuild,v 1.3 2004/01/08 02:46:23 avenj Exp $

DESCRIPTION="configurable talking ASCII cow (and other characters)"
HOMEPAGE="http://www.nog.net/~tony/warez/cowsay.shtml"
SRC_URI="http://www.nog.net/~tony/warez/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND=">=sys-apps/sed-4"
RDEPEND=">=dev-lang/perl-5"

src_install() {
	./install.sh ${D}/usr || "install problem"

	dodir /usr/share/${P}
	mv ${D}/usr/share/cows ${D}/usr/share/${P}

	cd ${D}/usr/bin
	sed	-i "s|${D}/usr/share/cows|/usr/share/${P}/cows|g" cowsay || \
		die "sed cowsay failed"
	chmod 755 cowsay

	# Oh what an ugly hack.  install.sh installs into /usr/man so just
	# "use that energy" and kill it off after doman is done with it.
	cd ${D}/usr/man/man1
	sed -i "s|${D}/usr/share/cows|/usr/share/${P}/cows|g" cowsay.1
	doman cowsay.1
	cd ${D}/usr/share/man/man1
	ln -s cowsay.1.gz cowthink.1.gz
	rm -rf ${D}/usr/man

}
