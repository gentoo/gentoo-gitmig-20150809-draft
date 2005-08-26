# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/eclass/gdesklets.eclass,v 1.10 2005/08/26 19:44:10 nixphoeni Exp $
#
# Authors:	Joe Sapp <nixphoeni@gentoo.org>
#		Mike Gardiner <obz@gentoo.org>
#
# Usage:
# As a writer for an ebuild for gDesklets, you should set a few things:
#
#	DESKLET_NAME: The name of the desklet.
#	DOCS: Anything (like a README) that should be dodoc'd.
#	S: *Optional* The package's base directory.
#		Usually ${WORKDIR}/${DESKLET_NAME} if it was packaged
#		correctly (hence, this is the default).
# 	RDEPEND: *Optional* Set if the desklet requires a minimum version
#		of gDesklets greater than 0.34 or other packages.

inherit eutils multilib


MY_P="${DESKLET_NAME}-${PV}"
S=${WORKDIR}/${DESKLET_NAME}

SRC_URI="http://gdesklets.gnomedesktop.org/files/${MY_P}.tar.gz"

# Ebuild writer shouldn't need to touch these (except maybe $RDEPEND)
SLOT="0"
IUSE=""
RDEPEND=">=gnome-extra/gdesklets-core-0.34.3"

GDESKLETS_INST_DIR="/usr/$(get_libdir)/gdesklets"

gdesklets_src_install() {

	debug-print-function $FUNCNAME $*

	has_version ">=gnome-extra/gdesklets-core-0.33.1" || \
				GDESKLETS_INST_DIR="/usr/share/gdesklets"

	# This should be done by the gdesklets-core ebuild
	# It makes the Displays or Controls directory in the
	# global installation directory if it doesn't exist
	[[ -d ${GDESKLETS_INST_DIR}/Displays ]] || \
		dodir ${GDESKLETS_INST_DIR}/Displays

	# The displays only need to be readable
	insopts -m0744

	# Check to see if DISPLAY is set for the
	# gdesklets-control-getid script to run without
	# error
	[ -z "${DISPLAY}" ] && DISPLAY=""
	export DISPLAY

	# First, install the Sensor (if there is one)
	if [[ -n "${SENSOR_NAME}" ]]; then
		for SENS in ${SENSOR_NAME[@]}; do
			einfo "Installing Sensor ${SENS}"
			/usr/bin/python "Install_${SENS}_Sensor.bin" \
					--nomsg ${D}${GDESKLETS_INST_DIR}/Sensors || \
					die "Couldn't Install Sensor"

			chown -R root:0 ${D}${GDESKLETS_INST_DIR}/Sensors/${SENSOR_NAME}
		done # for in ${SENSOR_NAME}
	fi # if -n "${SENSOR_NAME}"

	# This finds the Displays
	DISPLAY_FILES=(`find . -iname "*.display"`)

	GD_INSDIR=""

	# There is more than likely only one display per package
	if [[ -n "${DISPLAY_FILES[@]}" ]]; then
		# Base installation directory for displays
		GD_INSDIR="${GDESKLETS_INST_DIR}/Displays/${DESKLET_NAME}"

		# This creates the subdirectory of ${DESKLET_NAME}
		# in the global Displays directory
		[[ -d ${GD_INSDIR} ]] || \
			dodir ${GD_INSDIR}

		# For each of the Display files, there may be
		# scripts included inline which don't necessarily
		# follow any naming scheme.
		# So for each of them, determine what those scripts are
		# and install them.
		for DSP in ${DISPLAY_FILES[@]}; do

			einfo "Installing Display `basename ${DSP} .display`"
			insinto ${GD_INSDIR}
			doins ${DSP}

			SCRIPTS=$(grep "script .*uri" ${DSP} | \
				sed -e 's:.*<script .*uri=": :g' -e 's:"/>.*: :g')

			# For each one of the scripts, change to its
			# base directory and change the install location
			# so it gets installed at the proper place
			# relative to the display.
			for SCR in ${SCRIPTS[@]}; do

				cd `dirname ${DSP}`/`dirname ${SCR}`

				insinto ${GD_INSDIR}/`dirname ${SCR}`
				doins `basename ${SCR}`

				cd ${S}/`dirname ${DSP}`

			done # for in ${SCRIPTS}

			# Install the graphics for this display.
			# If there are multiple displays in this
			# directory, this will be done more than
			# once.  It's the only solution I can
			# come up with for now...
			GFX=(`find . \
					-iname "*.png" -o -iname "*.svg" \
					-o -iname "*.jpg" -o -iname "*.gif" \
					-o -iname "*.xcf"`)

			for G in ${GFX[@]}; do

				insinto ${GD_INSDIR}/`dirname ${G}`
				doins ${G}

			done # for in ${GFX}

			cd ${S}

		done # for in ${DISPLAY_FILES}

	fi

	# Make sure that it only finds Controls and not Sensors
	# If it uses a Sensor, it shouldn't use a Control (since
	# Sensors are deprecated).
	if [[ -z "${SENSOR_NAME}" ]]; then

		# Base installation directory for Controls
		GD_INSDIR="${GDESKLETS_INST_DIR}/Controls"

		CONTROL_INITS=$(find . -iname "__init__.py" | grep [Cc]ontrols)

		# There are possibly multiple Controls packaged with the display.
		# For each __init__.py found, there must be a Control associated with it.
		for CTRL in ${CONTROL_INITS[@]}; do

			cd `dirname ${CTRL}`
			CTRL_NAME=$( PYTHON_DONTCOMPILE=1 ${GDESKLETS_INST_DIR}/gdesklets-control-getid `pwd` )
			einfo "Installing Control ${CTRL_NAME}"
			# This creates the subdirectory of ${CTRL_NAME}
			# in the global Controls directory
			[[ -d ${GD_INSDIR}/${CTRL_NAME} ]] || \
				dodir ${GD_INSDIR}/${CTRL_NAME}

			insinto ${GD_INSDIR}/${CTRL_NAME}

			doins -r *

			cd ${S}

		done # for in ${CONTROL_INITS}

	fi # if no Sensors

	# Install any remaining graphics and other files
	# that are sitting in ${S}.

	GFX=$(find . -maxdepth 1 \
		-iname "*.png" -o -iname "*.svg" \
		-o -iname "*.jpg" -o -iname "*.gif" \
		-o -iname "*.xcf")

	if [[ -n "${GFX}" ]]; then
		# Install to the Displays directory of the Desklet
		insinto ${GDESKLETS_INST_DIR}/Displays/${DESKLET_NAME}
		doins ${GFX}
	fi # if -n "${GFX}"

	# Install some docs if so requested
	[[ -n "${DOCS}" ]] && dodoc ${DOCS}

}


EXPORT_FUNCTIONS src_install
