# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdcat/cdcat-0.2.ebuild,v 1.3 2002/07/25 16:55:21 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CD Catalog is a simple yet effective CD indexing program."
SRC_URI="http://www.littledragon.f2s.com/unix/cdcat/cdcat-0.2.tar.gz"
HOMEPAGE="http://www.littledragon.f2s.com/unix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-3.02.80
	>=sys-apps/grep-2.4.2
	>=sys-apps/findutils-4.1
	>=app-cdr/cdrtools-1.11"

src_unpack() {
	unpack ${A}
	cd ${S}

	# workaround install.sh ignoring --man_prefix
	t="install.sh"
	cp $t $t.orig || die "Patch failed for $t"
	sed 's:^MAN_PREFIX:#\1:' $t.orig > $t

	# fix path to cd index files to be FHS-compliant
	t="src/cdcat.pl"
	cp $t $t.orig || die "Patch failed for $t"
	sed 's:/mnt/ext/cd:/var/lib/cdcat:' $t.orig > $t
}

src_install() {
	# workaround install.sh ignoring --man_prefix
	export MAN_PREFIX=${D}/usr/share/man
	mkdir -p $MAN_PREFIX/man1

	# create index files path
	mkdir -p       ${D}/var/lib/cdcat
	chgrp cdrom    ${D}/var/lib/cdcat
	chmod g+ws,o+w ${D}/var/lib/cdcat

	# now use the included install.sh
	./install.sh --prefix=${D}/usr \
		--man_prefix=${D}/usr/share/man || die "Install script failed."
}
