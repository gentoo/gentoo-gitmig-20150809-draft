# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evms/evms-2.5.5-r1.ebuild,v 1.1 2006/05/02 08:14:30 eradicator Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
HOMEPAGE="http://www.sourceforge.net/projects/evms"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="ncurses gtk"

#EVMS uses libuuid from e2fsprogs
DEPEND="virtual/libc
	sys-fs/e2fsprogs
	sys-fs/device-mapper
	>=sys-apps/baselayout-1.9.4-r6
	gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses
	           =dev-libs/glib-1* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}/raid5_degrade_fix.patch 
	epatch ${FILESDIR}/${PV}/md_super_fix.patch
}

src_compile() {
	# Bug #54856
	# filter-flags "-fstack-protector"
	replace-flags -O3 -O2
	replace-flags -Os -O2

	local excluded_interfaces=""
	use ncurses || excluded_interfaces="--disable-text-mode"
	use gtk || excluded_interfaces="${excluded_interfaces} --disable-gui"

	econf \
		--libdir=/$(get_libdir) \
		--sbindir=/sbin \
		--includedir=/usr/include \
		${excluded_interfaces} || die "Failed configure"
	emake || die "Failed emake"
}

src_install() {
	make DESTDIR="${D}" install || die "Make install died"
	dodoc ChangeLog INSTALL* PLUGIN.IDS README TERMINOLOGY doc/linuxrc

	insinto /$(get_libdir)/rcscripts/addons
	newins "${FILESDIR}"/evms2-start.sh evms-start.sh || die "rcscript addon failed"

	# install the sample configuration into the doc dir
	dodoc ${D}/etc/evms.conf.sample
	rm -f ${D}/etc/evms.conf.sample

	# the kernel patches may come handy for people compiling their own kernel
	docinto kernel/2.4
	dodoc kernel/2.4/*
	docinto kernel/2.6
	dodoc kernel/2.6/*

	# move static libraries to /usr/lib
	dodir /usr/$(get_libdir)
	mv -f ${D}/$(get_libdir)/*.a ${D}/usr/$(get_libdir)

	# Create linker scripts for dynamic libs in /lib, else gcc
	# links to the static ones in /usr/lib first.  Bug #4411.
	for x in ${D}/usr/$(get_libdir)/*.a
	do
		if [ -f ${x} ]
		then
			local lib="${x##*/}"
			gen_usr_ldscript ${lib/\.a/\.so}
		fi
	done

	# the gtk+ frontend should live in /usr/sbin
	if use gtk
	then
		dodir /usr/sbin
		mv -f ${D}/sbin/evmsgui ${D}/usr/sbin
	fi

	# Needed for bug #51252
	dosym libevms-2.5.so.0.0 /$(get_libdir)/libevms-2.5.so.0
}
