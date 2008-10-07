# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.6.27_rc9.ebuild,v 1.1 2008/10/07 20:28:55 armin76 Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~alpha ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

K_EXTRAEWARN="If your system utilizes the e1000e driver DO NOT install and run
any 2.6.27 kernel.  See bug #238489 for more information"
