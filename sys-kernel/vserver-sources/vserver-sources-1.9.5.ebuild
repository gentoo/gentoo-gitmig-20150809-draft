# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-1.9.5.ebuild,v 1.1 2005/03/29 14:15:38 hollow Exp $

ETYPE="sources"
CKV="2.6.11.6"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2 eutils
detect_version

VSPV="${PV/_rc/-rc}"
PATCHR="00"

DESCRIPTION="vserver patched sources for the ${KV_MAJOR}.${KV_MINOR} kernel branch"
HOMEPAGE="http://www.linux-vserver.org"
SRC_URI="${KERNEL_URI} 	mirror://gentoo/vspatches-${VSPV}-${PATCHR}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="ngnet"

UNIPATCH_LIST="${DISTDIR}/vspatches-${VSPV}-${PATCHR}.tar.bz2"
UNIPATCH_STRICTORDER=1

pkg_setup() {
	use ngnet || UNIPATCH_EXCLUDE="9910"
}
