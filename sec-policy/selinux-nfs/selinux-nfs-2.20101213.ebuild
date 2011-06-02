# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-2.20101213.ebuild,v 1.2 2011/06/02 12:40:25 blueness Exp $

MODS="rpc"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="amd64 x86"
