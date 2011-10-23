# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-haveged/selinux-haveged-2.20101213-r2.ebuild,v 1.2 2011/10/23 12:43:03 swift Exp $

EAPI=3

DESCRIPTION="SELinux policy for haveged (meta-package for selinux-audio-entropyd)"
HOMEPAGE="http://hardened.gentoo.org/selinux"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=sec-policy/selinux-audio-entropyd-2.20101213-r1"
