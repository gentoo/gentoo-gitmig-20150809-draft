# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yard/yard-2.2.ebuild,v 1.6 2003/06/21 21:19:41 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yard is a suite of Perl scripts for creating rescue disks (also
called bootdisks) for Linux."
SRC_URI="http://www.linuxlots.com/~fawcett/yard/${P}.tar.gz
	http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}-extra.tar.bz2
	http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/diet-utils.tar.bz2"
HOMEPAGE="http://www.linuxlots.com/~fawcett/yard/"
SLOT="0"
LICENSE="GPL-2 Artistic"
KEYWORDS="x86 amd64 -ppc"
DEPEND="dev-lang/perl"
RDEPEND=""

src_unpack() {
	unpack ${P}-extra.tar.bz2 
	mv ${S} ${S}-extra
	unpack ${P}.tar.gz
	cd ${S}
	patch -p0 -l < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	./configure || die
	make || die
}

src_install() {
	make install DESTDIR=${D} || die
	make customize DESTDIR=${D} || die
	dodoc 0_* README VERSION
	dohtml doc/*.html

	cd ${S}-extra
	insinto /etc/yard
	doins etc/Bootdisk* etc/Config.pl
	insinto /etc/yard/Replacements/etc
	doins etc/Replacements/etc/[a-z]*
	chmod +x ${D}/etc/yard/Replacements/etc/rc
	insinto /etc/yard/Replacements/etc/pam.d
	doins etc/Replacements/pam.d/other
	insinto /etc/yard/Replacements/root
	doins etc/Replacements/root/profile

        # modified scripts

	exeinto /usr/sbin
	doexe sbin/{*_root_fs,mklibs.sh,write_rescue_disk,reduce_libs_root_fs}

        # devices

	dodir /etc/yard/Replacements/dev
	cd ${D}/etc/yard/Replacements/dev
	for i in hda hdb hdc hdd hde hdf hdg hdh scd
	do
		MAKEDEV $i
	done

	# diet-utils
	dodir /etc/yard/Replacements/bin
	cd ${D}/etc/yard/Replacements/bin
	tar xjpf ${DISTDIR}/diet-utils.tar.bz2
}
