#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter merlin merlinx lava,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)

VULKAN_SYMLINKS := $(TARGET_OUT_VENDOR)
$(VULKAN_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating vulkan symlinks: $@"
	@mkdir -p $@/lib/hw/
	@mkdir -p $@/lib64/hw/
	@ln -sf $@/lib/egl/libGLES_mali.so $@/lib/hw/vulkan.$(TARGET_BOARD_PLATFORM).so
	@ln -sf $@/lib64/egl/libGLES_mali.so $@/lib64/hw/vulkan.$(TARGET_BOARD_PLATFORM).so

ALL_DEFAULT_INSTALLED_MODULES += $(VULKAN_SYMLINKS)

VENDOR_SYMLINKS := \
    $(TARGET_OUT_VENDOR) \
    $(TARGET_OUT_VENDOR)/lib/hw \
    $(TARGET_OUT_VENDOR)/lib64/hw

$(VENDOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Making vendor symlinks"
	@ln -sf /mnt/vendor/cust $(TARGET_OUT_VENDOR)/cust
	@ln -sf /mnt/vendor/nvcfg $(TARGET_OUT_VENDOR)/nvcfg
	@ln -sf /mnt/vendor/nvdata $(TARGET_OUT_VENDOR)/nvdata
	@ln -sf /mnt/vendor/persist $(TARGET_OUT_VENDOR)/persist
	@ln -sf /mnt/vendor/protect_f $(TARGET_OUT_VENDOR)/protect_f
	@ln -sf /mnt/vendor/protect_s $(TARGET_OUT_VENDOR)/protect_s
	@mkdir -p $(TARGET_OUT_VENDOR)/lib/hw
	@mkdir -p $(TARGET_OUT_VENDOR)/lib64/hw
	@ln -sf libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so
	@ln -sf libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.default.so
	@ln -sf /vendor/lib/egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib/hw/vulkan.mt6768.so
	@ln -sf /vendor/lib64/egl/libGLES_mali.so $(TARGET_OUT_VENDOR)/lib64/hw/vulkan.mt6768.so
	$(hide) touch $@

ALL_DEFAULT_INSTALLED_MODULES += $(VENDOR_SYMLINKS)

endif
