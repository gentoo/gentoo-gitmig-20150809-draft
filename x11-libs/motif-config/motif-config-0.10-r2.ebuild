# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/motif-config/motif-config-0.10-r2.ebuild,v 1.9 2008/04/13 22:06:22 vapier Exp $

inherit multilib

DESCRIPTION="Utility to change the default Motif library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}-bindings.tar.bz2
	mirror://gentoo/${P}-bitmaps.tar.bz2"

LICENSE="GPL-2 MOTIF"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

# These blockers are here for transition to a single, non-slotted
# motif implementation. We are forcing users to unmerge all other
# slots and implementations before upgrading.
DEPEND="!<x11-libs/openmotif-2.3.0
	!x11-libs/lesstif"
RDEPEND="${DEPEND}"
PDEPEND=">=x11-libs/openmotif-2.3.0"

src_install() {
	newbin "${FILESDIR}"/${P} motif-config || die
	dosed "s:@@LIBDIR@@:$(get_libdir):g" /usr/bin/motif-config

	# for profile
	keepdir /usr/$(get_libdir)/motif

	# bitmaps
	insinto /usr/include/X11/bitmaps
	doins bitmaps/*

	# bindings
	insinto /usr/$(get_libdir)/X11/bindings
	doins bindings/*

	# mwm default config
	insinto /etc/X11/app-defaults
	doins "${FILESDIR}"/Mwm.defaults

	insinto /etc/X11/mwm
	doins "${FILESDIR}"/system.mwmrc

	dodir /usr/$(get_libdir)/X11
	dosym /etc/X11/mwm /usr/$(get_libdir)/X11/mwm
}

pkg_preinst() {
	# clean up orphaned cruft left over by old versions
	local staledirs="usr/$(get_libdir)/motif/openmotif-2.1 \
				usr/$(get_libdir)/motif/openmotif-2.1 \
				usr/include/openmotif-2.1 \
				usr/$(get_libdir)/openmotif-2.1 \
				usr/$(get_libdir)/motif/openmotif-2.2 \
				usr/include/openmotif-2.2 \
				usr/$(get_libdir)/openmotif-2.2 \
				usr/$(get_libdir)/motif/lesstif-1.2 \
				usr/include/lesstif-1.2 \
				usr/$(get_libdir)/lesstif-1.2 \
				usr/$(get_libdir)/motif/lesstif-2.1 \
				usr/include/lesstif-2.1 \
				usr/$(get_libdir)/lesstif-2.1 \
				usr/include/Xm \
				usr/include/uil \
				usr/include/Mrm"

	for i in ${staledirs} ; do
		if [[ -d "${ROOT}"${i} ]] ; then
			einfo "Cleaning up orphaned ${ROOT}${i}..."
			rm -rf "${ROOT}"${i}
		fi
	done
}

pkg_postinst() {
	# when emerged after openmotif, then we need to set to a valid
	# profile since we nuked the symlinks in pkg_preinst (Bug 209982)
	# this sucky stuff can go away once openmotif is moved to SLOT=0
	has_version x11-libs/openmotif && motif-config -s
}
