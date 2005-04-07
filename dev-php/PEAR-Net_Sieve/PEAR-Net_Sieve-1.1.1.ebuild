# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_Sieve/PEAR-Net_Sieve-1.1.1.ebuild,v 1.8 2005/04/07 20:58:45 hansmi Exp $

inherit php-pear

DESCRIPTION="Provides an API to talk to the timsieved server that comes with Cyrus IMAPd. Can be used to install, remove, mark active etc sieve scripts."
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc ia64 amd64 ~hppa ppc64"
IUSE=""
RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.0"
