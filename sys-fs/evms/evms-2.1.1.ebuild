# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evms/evms-2.1.1.ebuild,v 1.2 2003/12/22 16:50:28 iggy Exp $

IUSE="ncurses gtk"

inherit eutils

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/evms-${PV}-gentoo.patch"
HOMEPAGE="http://www.sourceforge.net/projects/evms"

KEYWORDS="x86 -amd64 -ppc -sparc -alpha -arm -hppa -mips"
LICENSE="GPL-2"
SLOT="0"

#EVMS uses libuuid from e2fsprogs
DEPEND="virtual/glibc
	sys-fs/e2fsprogs
	gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${DISTDIR}/evms-${PV}-gentoo.patch
	autoconf
}

src_compile() {
	local excluded_interfaces=""
	use ncurses || excluded_interfaces="--disable-text-mode"
	use gtk || excluded_interfaces="${excluded_interfaces} --disable-gui"

	./configure \
		--prefix=/usr \
		--libdir=/lib \
		--sbindir=/sbin \
		--mandir=/usr/share/man \
		--includedir=/usr/include \
		${excluded_interfaces} || die "Failed configure"
	emake || die "Failed emake"
}

src_install() {
	make DESTDIR=${D} install || die "Make install died"
	dodoc ChangeLog COPYING TERMINOLOGY PLUGIN.IDS INSTALL INSTALL.HA INSTALL.initrd

	# move static libraries to /usr/lib
	dodir /usr/lib
	mv -f ${D}/lib/*.a ${D}/usr/lib

	# Create linker scripts for dynamic libs in /lib, else gcc
	# links to the static ones in /usr/lib first.  Bug #4411.
	for x in ${D}/usr/lib/*.a
	do
		if [ -f ${x} ]
		then
			local lib="${x##*/}"
			gen_usr_ldscript ${lib/\.a/\.so}
		fi
	done

	# realize these symlinks now so they get included
	cd ${D}/lib
	rm -f libdlist.so libevms.so
	ln -sf libevms-${PV}.so libevms.so.1
	ln -sf libevms.so.1 libevms.so
	ln -sf libdlist-1.0.so libdlist.so.1
	ln -sf libdlist.so.1 libdlist.so

	# the gtk+ frontend should live in /usr/sbin
	if [ -n "`use gtk`" ]
	then
		dodir /usr/sbin
		mv -f ${D}/sbin/evmsgui ${D}/usr/sbin
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/evms2-init evms
}

pkg_postinst() {

	ewarn "You just installed evms 2.1.0 - See the ChangeLog for current kernel support"
	ewarn "At this time, only pfeifer-sources-2.4.21_pre3 supports this."
	ewarn "Ensure you add evms2 to your use flags when emerging pfeifer-sources..."
	ewarn "If you do not, you will only have evms 1.2.1 support in the kernel."

}
