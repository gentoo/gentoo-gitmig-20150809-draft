# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evms/evms-2.5.5-r5.ebuild,v 1.8 2007/03/31 11:20:16 armin76 Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils flag-o-matic multilib toolchain-funcs autotools

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
HOMEPAGE="http://www.sourceforge.net/projects/evms"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86"
IUSE="debug gtk ncurses nls"

#EVMS uses libuuid from e2fsprogs
RDEPEND="virtual/libc
	sys-fs/e2fsprogs
	sys-fs/device-mapper
	>=sys-apps/baselayout-1.9.4-r6
	gtk? ( =x11-libs/gtk+-1*
		=dev-libs/glib-1* )
	ncurses? ( sys-libs/ncurses
		>=dev-libs/glib-2.12.4-r1 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}/md_super_fix.patch"
	epatch "${FILESDIR}/${PV}/ntfs_unmkfs.patch"
	epatch "${FILESDIR}/${PV}/raid5_degrade_fix.patch"
	epatch "${FILESDIR}/${PV}/raid5_remove_spare_fix.patch"
	epatch "${FILESDIR}/${PV}/raid5_remove_spare_fix_2.patch"
	epatch "${FILESDIR}/${PV}/raid5_algorithm.patch"
	epatch "${FILESDIR}/${PV}/cli_reload_options.patch"
	epatch "${FILESDIR}/${PV}/cli_query_segfault.patch"
	epatch "${FILESDIR}/${PV}/get_geometry.patch"
	epatch "${FILESDIR}/${PV}/BaseName.patch"

	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-glib_dep.patch"
	epatch "${FILESDIR}/${P}-ocfs2.patch"
	epatch "${FILESDIR}/${P}-use_disk_group.patch"
	epatch "${FILESDIR}/${P}-pagesize.patch"

	eautoreconf
}

src_compile() {
	# Bug #54856
	# filter-flags "-fstack-protector"
	replace-flags -O3 -O2
	replace-flags -Os -O2

	local excluded_interfaces=""
	use ncurses || excluded_interfaces="--disable-text-mode"
	use gtk || excluded_interfaces="${excluded_interfaces} --disable-gui"

	# We have to link statically against glib because evmsn resides in /sbin
	econf \
		--libdir=/$(get_libdir) \
		--sbindir=/sbin \
		--includedir=/usr/include \
		--with-static-glib \
		$(use_with debug) \
		$(use_enable nls) \
		${excluded_interfaces} || die "Failed configure"
	emake || die "Failed emake"
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install died"
	dodoc ChangeLog INSTALL* PLUGIN.IDS README TERMINOLOGY doc/linuxrc

	insinto /$(get_libdir)/rcscripts/addons
	newins "${FILESDIR}/evms2-start.sh" evms-start.sh || die "rcscript addon failed"

	# install the sample configuration into the doc dir
	dodoc "${D}/etc/evms.conf.sample"
	rm -f "${D}/etc/evms.conf.sample"

	# the kernel patches may come handy for people compiling their own kernel
	docinto kernel/2.4
	dodoc kernel/2.4/*
	docinto kernel/2.6
	dodoc kernel/2.6/*

	# move static libraries to /usr/lib
	dodir /usr/$(get_libdir)
	mv -f ${D}/$(get_libdir)/*.a "${D}/usr/$(get_libdir)"

	# Create linker scripts for dynamic libs in /lib, else gcc
	# links to the static ones in /usr/lib first.  Bug #4411.
	for x in "${D}/usr/$(get_libdir)"/*.a ; do
		if [ -f ${x} ] ; then
			local lib="${x##*/}"
			gen_usr_ldscript ${lib/\.a/\.so}
		fi
	done

	# the gtk+ frontend should live in /usr/sbin
	if use gtk ; then
		dodir /usr/sbin
		mv -f ${D}/sbin/evmsgui ${D}/usr/sbin
	fi

	# Needed for bug #51252
	dosym libevms-2.5.so.0.0 /$(get_libdir)/libevms-2.5.so.0
}

src_test() {
	if [[ -z ${EVMS_TEST_VOLUME} ]] ; then
		eerror "This is a volume manager and it therefore needs a volume"
		eerror "for testing. You have to define EVMS_TEST_VOLUME as"
		eerror "a volume evms can operate on."
		eerror "Example: export EVMS_TEST_VOLUME=sda"
		eerror "Note: The volume-name can not be a symlink."
		eerror "WARNING: EVMS WILL DESTROY EVERYTHING ON IT."
		einfo "If you don't have an empty disk, you can use the loopback-device:"
		einfo "- Create a large file using dd (this creates a 4GB file):"
		einfo "  dd if=/dev/zero of=/tmp/evms_test_file bs=1M count=4096"
		einfo "- Activate a loop device on this file:"
		einfo "  losetup /dev/loop0 /tmp/evms_test_file"
		einfo "- export EVMS_TEST_VOLUME=loop/0"
		einfo "The disk has to be at least 4GB!"
		einfo "To deactivate the loop-device afterwards:"
		einfo "- losetup -d /dev/loop0"
		hasq userpriv ${FEATURES} && ewarn "These tests have to run as root. Disable userpriv!"
		die "need test-volume"
	fi

	if hasq userpriv ${FEATURES} ; then
		eerror "These tests need root privileges. Disable userpriv!"
		die "userpriv is not supported"
	fi

	volume=$(readlink "/dev/${EVMS_TEST_VOLUME}")
	einfo "Disabling sandbox for:"
	einfo " - /dev/${volume:-${EVMS_TEST_VOLUME}}"
	addwrite /dev/${volume:-${EVMS_TEST_VOLUME}}
	einfo " - /dev/evms"
	addwrite /dev/evms
	einfo " - /var/lock/evms-engine"
	addwrite /var/lock/evms-engine

	cd "${S}/tests/suite"
	PATH="${S}/ui/cli:${S}/tests:/sbin:${PATH}" ./run_tests ${EVMS_TEST_VOLUME} || die "tests failed"
}
