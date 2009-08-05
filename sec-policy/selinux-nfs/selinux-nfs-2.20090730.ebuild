# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-2.20090730.ebuild,v 1.1 2009/08/05 13:35:14 pebenito Exp $

MODS="rpc"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="~amd64 ~x86"
