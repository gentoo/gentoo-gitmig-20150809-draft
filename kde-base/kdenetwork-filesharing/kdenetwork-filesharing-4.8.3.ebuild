# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-filesharing/kdenetwork-filesharing-4.8.3.ebuild,v 1.4 2012/05/24 08:43:53 ago Exp $

EAPI=4

KMNAME="kdenetwork"
KMMODULE="filesharing"
inherit kde4-meta

DESCRIPTION="kcontrol filesharing config module for NFS, SMB etc"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
