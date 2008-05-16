# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.0.4.ebuild,v 1.1 2008/05/16 00:48:24 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
KMMODULE=libs/kworkspace
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

KMEXTRACTONLY="
	ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml"
KMSAVELIBS="true"
