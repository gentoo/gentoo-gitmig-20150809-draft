# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/selinux-small/selinux-small-2003081400.ebuild,v 1.1 2003/09/05 19:20:05 pebenito Exp $

DESCRIPTION="SELinux old api to new api transition package"
HOMEPAGE="http://www.nsa.gov/selinux/"

DEPEND="sys-libs/libselinux
	sys-apps/checkpolicy
	sys-apps/policycoreutils"

# The new SELinux API for 2.6 (and late 2.4) no longer uses
# selinux-small and libsecure.  The new API is based on 
# libselinux.  This package is for helping to get a
# libsecure installation updated to a libselinux version.

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
