# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdcat/cdcat-0.3.ebuild,v 1.3 2003/05/04 19:20:51 mholzer Exp $

DESCRIPTION="simple yet effective CD indexing program"
SRC_URI="http://littledragon.home.ro/unix/${P}.tar.gz"
HOMEPAGE="http://littledragon.home.ro/unix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-apps/grep-2.4.2
	>=sys-apps/findutils-4.1
	>=app-cdr/cdrtools-1.11"

src_unpack() {
	unpack ${A}
	cd ${S}

	# workaround install.sh ignoring --man_prefix
	t="install.sh"
	cp $t $t.orig || die "Patch failed for $t"
	sed 's:^MAN_PREFIX:#:' $t.orig > $t

	# fix path to cd index files to be FHS-compliant
	t="src/cdcat.pl"
	cp $t $t.orig || die "Patch failed for $t"
	sed 's:/mnt/ext/cd:/var/lib/cdcat:' $t.orig > $t
}

src_install() {
	# workaround install.sh ignoring --man_prefix
	export MAN_PREFIX=${D}/usr/share/man
	dodir /usr/share/man/man1

	# create index files path
	dodir          /var/lib/cdcat
	chgrp cdrom    ${D}/var/lib/cdcat
	chmod g+ws,o+w ${D}/var/lib/cdcat

	# now use the included install.sh
	./install.sh --prefix=${D}/usr \
		--man_prefix=${D}/usr/share/man || die "Install script failed."
}
