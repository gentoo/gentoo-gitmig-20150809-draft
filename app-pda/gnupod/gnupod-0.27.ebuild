# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnupod/gnupod-0.27.ebuild,v 1.2 2003/07/02 11:55:13 aliz Exp $

DESCRIPTION="Tools for updating your iPod"

HOMEPAGE="http://www.gnu.org/software/gnupod/"
#"Soon" will be on the gnu mirrors...
SRC_URI="http://blinkenlights.ch/gnupod/${PN}-tools-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc"

IUSE=""

DEPEND=">=dev-lang/perl-5.6.1-r11
	dev-perl/MP3-Info
	dev-perl/Unicode-String
	dev-perl/XML-Simple
	dev-perl/Getopt-Mixed"


# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.
S=${WORKDIR}/${PN}-tools

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=${D}/usr \
		--infodir=${D}/usr/share/info \
		--mandir=${D}/usr/share/man || die "./configure failed"
}

src_install() {

	#unfortunately, this package is not really autoconfed...
	cd ${S}/tools || die
	mv gnupod_install.pl gnupod_install.pl.orig || die
	sed -e 's:"Installing $INC\[0\]:"Installing ".$prefix."$INC\[0\]:' \
		-e 's:$_, "$INC\[0\]/$file:$_, $prefix."$INC\[0\]/$file:' \
		-e 's:0444, "$INC\[0\]:0444, $prefix."$INC\[0\]:' \
		-e 's:0, 0, "$INC\[0\]:0, 0, $prefix."$INC\[0\]:' \
		-e 's:if !$INC\[0\];:& my $prefix="'${D}'";:' \
		-e 's:open(TARGET, ">\(.*\)"):my $tmp="\1"; $tmp =~ s,/[^/]*$,,; system("mkdir -p $tmp"); &:' \
		-e 's:system("install-info --info-dir=$infodir $file"):system("mkdir -p $infodir") \&\& system("cp $file $infodir"):' \
		gnupod_install.pl.orig > gnupod_install.pl || die

	rm gnupod_install.pl.orig
	cd ${S}

	make install

	dodoc CHANGES
	cd ${S}/doc
	dodoc gnupod.html gnutunesdb.example 
}
