# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yard/yard-2.2.ebuild,v 1.1 2002/08/25 20:17:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yard is a suite of Perl scripts for creating rescue disks (also
called bootdisks) for Linux."
SRC_URI="http://www.linuxlots.com/~fawcett/yard/${P}.tar.gz"
HOMEPAGE="http://www.linuxlots.com/~fawcett/yard/"
SLOT="0"
LICENSE="GPL-2 Artistic"
KEYWORDS="x86 -ppc"
DEPEND="sys-devel/perl"
RDEPEND=""

src_unpack() {
	unpack ${A}
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

	cd ${FILESDIR}/${P}
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
	tar xjpf ${FILESDIR}/diet-utils.tar.bz2
}
