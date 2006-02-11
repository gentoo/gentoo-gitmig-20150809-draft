# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/extrackt/extrackt-9999.ebuild,v 1.1 2006/02/11 05:24:48 vapier Exp $

ECVS_MODULE="e17/proto/extrackt"
inherit enlightenment

DESCRIPTION="an audio CD ripper and encoder"

DEPEND="dev-libs/eet
	x11-libs/ecore
	x11-libs/evas
	x11-libs/etk
	dev-util/enhance"
