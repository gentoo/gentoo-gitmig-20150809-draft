# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/linux-sources/linux-sources-3.ebuild,v 1.1 2011/07/25 14:07:27 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="hardened xrc"

DEPEND=""
RDEPEND="|| (
		hardened? ( =sys-kernel/hardened-sources-3* )
		xrc? ( =sys-kernel/cluster-sources-3* )
		=sys-kernel/gentoo-sources-3*
		=sys-kernel/vanilla-sources-3*
		=sys-kernel/cell-sources-3*
		=sys-kernel/ck-sources-3*
		=sys-kernel/git-sources-3*
		=sys-kernel/hardened-sources-3*
		=sys-kernel/mips-sources-3*
		=sys-kernel/mm-sources-3*
		=sys-kernel/openvz-sources-3*
		=sys-kernel/pf-sources-3*
		=sys-kernel/tuxonice-sources-3*
		=sys-kernel/usermode-sources-3*
		sys-kernel/vserver-sources
		=sys-kernel/xbox-sources-3*
		=sys-kernel/xen-sources-3*
		=sys-kernel/zen-sources-3*
	)"
