# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-plugins/gkrellm-plugins-1.2.11-r1.ebuild,v 1.3 2002/07/04 02:22:02 seemant Exp $ 

S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="emerge this package to install all of the gkrellm plugins"

DEPEND=">=app-admin/gkrellm-1.2.11
		>=x11-misc/gkrellm-bfm-0.5.1
		>=x11-misc/gkrellm-console-0.1
		>=x11-misc/gkrellm-mailwatch-0.7.2
		>=x11-misc/gkrellm-radio-0.3.3
		>=x11-misc/gkrellm-reminder-0.3.5
		>=x11-misc/gkrellm-volume-0.8
		>=x11-misc/gkrellmitime-0.4
		>=x11-misc/gkrellmlaunch-0.3
		>=x11-misc/gkrellmms-0.5.6
		>=x11-misc/gkrellmoon-0.3
		>=x11-misc/gkrellmouse-0.0.2
		>=x11-misc/gkrellmwho-0.4
		>=x11-misc/gkrellmwireless-0.2.2
		>=x11-misc/gkrellshoot-0.3.11
		>=x11-misc/gkrellweather-0.2.7-r2
		gnome? ( >=x11-misc/gkrellm-gnome-0.1 )"

RDEPEND="${DEPEND}"
