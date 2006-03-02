# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.4.32.ebuild,v 1.2 2006/03/02 21:13:25 gimli Exp $

ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="x86 -*"
IUSE=""

UNIPATCH_STRICTORDER='Y'
UNIPATCH_LIST="${DISTDIR}/${PF}.tar.bz2"

DESCRIPTION="Full sources for the Xbox Linux kernel"
HOMEPAGE="http://www.xbox-linux.org"

SRC_URI="${KERNEL_URI} mirror://gentoo/${PF}.tar.bz2"
K_NOSETEXTRAVERSION="don't_set_it"

