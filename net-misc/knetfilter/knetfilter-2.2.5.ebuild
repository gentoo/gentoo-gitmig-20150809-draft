# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetfilter/knetfilter-2.2.5.ebuild,v 1.7 2002/08/14 12:08:08 murphy Exp $

inherit kde-base || die

need-kde 2.2

S=${WORKDIR}/${P}
DESCRIPTION="Manage Iptables firewalls with this KDE app"
SRC_URI="http://expansa.sns.it:8080/knetfilter/${P}.tar.gz"
HOMEPAGE="http://expansa.sns.it:8080/knetfilter/"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"

newdepend ">=sys-apps/iptables-1.2.5"

src_unpack() {

    base_src_unpack
    kde_sandbox_patch ${S}/src ${S}/src/scripts
    
}
