# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-pre.eclass,v 1.5 2003/02/18 09:00:45 carpaski Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This is for kde prereleases (alpha, beta etc.) which have a _ (underscore) in their portage ebuild
# names but not in their source archives and source dirs. To be inherited after setting SRC_URI and WORKDIR.

ECLASS=kde-pre
INHERITED="$INHERITED $ECLASS"

[ -z "$DESCRIPTION" ] && DESCRIPTION="Based on the $ECLASS eclass"

S="${WORKDIR}/${PN}-${PV//_}"

SRC_PATH="kde/unstable/kde-${PV//_}/src/${P//_}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"
