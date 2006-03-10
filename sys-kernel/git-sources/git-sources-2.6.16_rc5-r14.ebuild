# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/git-sources/git-sources-2.6.16_rc5-r14.ebuild,v 1.1 2006/03/10 21:00:06 robbat2 Exp $

UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
ETYPE="sources"
CKV="${PVR/-r/-git}"
inherit kernel-2
detect_version


DESCRIPTION="The very latest -git version of the Linux kernel"
HOMEPAGE="http://www.kernel.org"
#SRC_URI="${KERNEL_URI} mirror://kernel/linux/kernel/v2.6/snapshots/patch-${KV_FULL}.bz2"
SRC_URI="${KERNEL_URI}"
KEYWORDS="~amd64 ~alpha ~arm ~ia64 ~ppc ~x86 ~ppc64"

K_EXTRAEINFO="This kernel is not supported by Gentoo due to its unstable and
experimental nature. If you have any issues, try a matching vanilla-sources
ebuild -- if the problem is not there, please contact the upstream kernel
developers at http://bugme.osdl.org and on the linux-kernel mailing list to
report the problem so it can be fixed in time for the next kernel release."

pkg_postinst() {
	postinst_sources
}
