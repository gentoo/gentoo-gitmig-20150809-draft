# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.0_beta1.ebuild,v 1.4 2002/07/11 06:30:12 drobbins Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for kde2"
SRC_URI="http://xm1.net.free.fr/kile/kile-beta1.0.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/kile/index.html"
LICENSE="GPL-2"
S=${WORKDIR}/kile-beta1.0

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

