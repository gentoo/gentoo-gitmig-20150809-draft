# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/magicfilter/magicfilter-1.2-r2.ebuild,v 1.3 2002/07/14 20:41:22 aliz Exp $

A=magicfilter-$PV.tar.gz
S=$WORKDIR/$P
DESCRIPTION="Customizable, extensible automatic printer filter"
SRC_URI="ftp://metalab.unc.edu/pub/linux/system/printing/$A"
HOMEPAGE="http://www.gnu.org/directory/magicfilter.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

# Others that perhaps should be added to this list as I figure out
# what packages they belong to...
#
#    checking for recode... no
#    checking for gs... /usr/bin/gs
#    checking for grog... /usr/bin/grog
#    checking for groff... /usr/bin/groff
#    checking for gtroff... no
#    checking for ditroff... no
#    checking for troff... /usr/bin/troff
#    checking for grops... /usr/bin/grops
#    checking for grodvi... /usr/bin/grodvi
#    checking for grotty... /usr/bin/grotty
#    checking for grolj4... /usr/bin/grolj4
#    checking for bzip2... /bin/bzip2
#    checking for gzip... /bin/gzip
#    checking for zcat... /bin/zcat
#    checking for uncompress... no
#    checking for dvips... no
#    checking for pnmtops... no
#    checking for pngtopnm... no
#    checking for giftopnm... no
#    checking for giftoppm... no
#    checking for djpeg... /usr/bin/djpeg
#    checking for sgitopnm... no
#    checking for tops... no
#    checking for sgitops... no
#    checking for tiff2ps... /usr/bin/tiff2ps
#    checking for tifftopnm... no
#    checking for bmptopnm... no
#    checking for bmptoppm... no
#    checking for rasttopnm... no
#    checking for nenscript... no
#    checking for enscript... no
#    checking for a2x... no
#    checking for a2ps... no
#    checking for fig2dev... no
#    checking whether zcat is really gzip... yes
#    checking whether ditroff works... yes
#    checking for sendmail... /usr/sbin/sendmail
DEPEND="virtual/glibc
        >=app-text/ghostscript-6.50-r2
	>=sys-apps/groff-1.16.1-r1
	>=sys-apps/bzip2-1.0.1-r4
	>=sys-apps/gzip-1.2.4a-r6"

src_unpack() {
    unpack $A
    # This is the patch directly from the Debian package.  It's included
    # here (instead of fetching from Debian) because their package
    # revisions will change faster than this ebuild will keep up...
    cd $S
    patch -p1 < $FILESDIR/magicfilter_1.2-39.diff || die
    patch -p1 < $FILESDIR/magicfilter-1.2-stc777.patch || die
    cp $FILESDIR/*-filter.x filters || die
}

src_compile() {
    ./configure --host="$CHOST" || die
    emake || die
    # Fixup the filters for /usr/sbin/magicfilter; eventually
    # magicfilterconf should be fixed up for
    # /usr/share/magicfilter/...  :-(
    cd filters
    for f in *-filter; do
	mv $f $f.old
	( read l; echo '#!/usr/sbin/magicfilter'; cat ) <$f.old >$f
    done
}

src_install() {
    dodir /usr/sbin /usr/share/man/man8 /usr/share/magicfilter
    install -m 755 magicfilter $D/usr/sbin
    install -m 755 magicfilter.man $D/usr/share/man/man8/magicfilter.8
    install -m 755 magicfilterconfig $D/usr/sbin
    install -m 644 magicfilterconfig.8 $D/usr/share/man
    install -m 755 filters/*-filter $D/usr/share/magicfilter
    install -m 755 $FILESDIR/stc777-text-helper $D/usr/share/magicfilter
    gzip -9f $D/usr/share/man/*/*
    gzip -9f filters/README*
    dodoc README QuickInst TODO debian/copyright 
    docinto filters
    dodoc filters/README*
}
