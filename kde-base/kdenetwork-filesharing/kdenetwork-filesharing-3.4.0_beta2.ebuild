# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-filesharing/kdenetwork-filesharing-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:16 danarmak Exp $

KMNAME=kdenetwork
KMMODULE=filesharing
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kcontrol filesharing config module for NFS, SMB etc"
KEYWORDS="~x86"
IUSE=""
DEPEND="!net-misc/ksambaplugin"