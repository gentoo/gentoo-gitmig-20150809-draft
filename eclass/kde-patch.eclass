# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-patch.eclass,v 1.4 2002/10/25 19:55:52 vapier Exp $
# This applies homemade patches from the tarball to the date specified.

ECLASS=kde-patch
INHERITED="$INHERITED $ECLASS"

debug-print "Entering eclass $ECLASS"

# ${PV} comes in the form of x.y.z.YYYYMMDD where x.y.z is the original (unpatched) version
# and YYYYMMDD is the patch's datestamp. The patch lives on a gentoo mirror and is called
# ${PN}-x.y.z-YYYYMMDD.diff. We figure out automagically the two parts of the current $PV.

# I'm not that good at regexps etc., so I emulate std coding practices

OLDIFS="$IFS" # backup so that we don't distort future loops
IFS="." # separator string that determines the breakup of a string by bash's "for x in; do; done"

for DATE in $PV
do
	# if not last component of separated $PV
	if [ ! "${ORIGPV}.${DATE}" == "${PV}" ]; then
	[ -n "$ORIGPV" ] && ORIGPV="${ORIGPV}.${DATE}" || ORIGPV="$DATE" # don't add a leading dot
	fi
done

IFS="$OLDIFS" #restore

# now $ORIGPV and $DATE should have the right values
debug-print "$ECLASS: ORIGPV=$ORIGPV, DATE=$DATE"

PATCH="${PN}-${ORIGPV}-${DATE}.diff"
SRC_URI="$SRC_URI mirror://gentoo/${PATCH}"

# for the new base_src_unpack functionality
PATCHES="$PATCHES ${DISTDIR}/${PATCH}"

# Set the right Pv for correct handling of the main sources. This is why this eclass
# should be sourced before all others.
PV="$ORIGPV"
[ "$PR" != "r0" ] && PVR="$PN-$PV-$PR" || PVR="$PV"
P="$PN-$PV"

