# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.100.0.ebuild,v 1.2 2011/09/03 21:05:26 tove Exp $

EAPI=4

MY_PN=Net-SFTP
MODULE_AUTHOR=DBROBINS
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Secure File Transfer Protocol client"

SLOT="0"
KEYWORDS="alpha amd64 ~mips ~ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/net-ssh-perl-1.25"
